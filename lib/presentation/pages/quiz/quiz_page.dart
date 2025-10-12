import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/models/category_model.dart';
import '../../../core/models/question_model.dart';
import 'widgets/option_button.dart';
import 'widgets/progress_indicator.dart';

class QuizPage extends StatefulWidget {
  final QuizCategory category;

  const QuizPage({super.key, required this.category});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestionIndex = 0;
  int correctAnswers = 0;
  int? selectedAnswerIndex;
  bool answered = false;

  @override
  void initState() {
    super.initState();
    // Debug opcional para ver qué id llega realmente
    // ignore: avoid_print
    print('QuizPage category.id -> "${widget.category.id}"');
  }

  // 🔁 Banco de preguntas por categoría (con normalización y mapeo)
  List<Question> getQuestionsForCategory(String rawId) {
    // 1) Normaliza: quita espacios y pasa a MAYÚSCULAS
    final id = rawId.trim().toUpperCase();

    // 2) Mapea ids antiguos 1–4 a los nuevos
    final categoryId = switch (id) {
      '1' => 'L348',
      '2' => 'FIN',
      '3' => 'YASTA',
      '4' => 'SEG',
      _ => id,
    };

    switch (categoryId) {
      case 'L348':
        return [
          Question(
            id: 'L1',
            categoryId: 'L348',
            question: '¿Cuál es el objetivo central de la Ley 348 en Bolivia?',
            options: [
              'Regular contratos de trabajo',
              'Garantizar a las mujeres una vida libre de violencia',
              'Controlar precios de servicios básicos',
              'Regular únicamente violencia física',
            ],
            correctAnswerIndex: 1,
            explanation:
                'La Ley 348 busca garantizar a las mujeres una vida libre de violencia, en todas sus formas.',
          ),
          Question(
            id: 'L2',
            categoryId: 'L348',
            question:
                '¿Qué tipos de violencia reconoce la Ley 348, además de la física?',
            options: [
              'Solo verbal',
              'Psicológica, sexual, económica y simbólica, entre otras',
              'Solo económica',
              'Únicamente en el hogar',
            ],
            correctAnswerIndex: 1,
            explanation:
                'La Ley 348 reconoce múltiples formas de violencia: psicológica, sexual, económica, simbólica y otras, no solo física.',
          ),
          Question(
            id: 'L3',
            categoryId: 'L348',
            question:
                'Si eres testigo de un hecho de violencia, ¿qué acción es correcta?',
            options: [
              'No intervenir nunca',
              'Publicarlo primero en redes sociales',
              'Buscar ayuda segura y denunciar ante la FELCV o el Ministerio Público',
              'Esperar a que “se arregle en casa”',
            ],
            correctAnswerIndex: 2,
            explanation:
                'Lo correcto es priorizar la seguridad y denunciar por las vías competentes (FELCV/Ministerio Público).',
          ),
          Question(
            id: 'L4',
            categoryId: 'L348',
            question:
                '¿Qué medida ayuda a prevenir la violencia según el enfoque de la Ley 348?',
            options: [
              'Normalizar los “celos” como prueba de amor',
              'Promover relaciones respetuosas e igualdad de derechos',
              'Evitar hablar del tema',
              'Culpar a la víctima',
            ],
            correctAnswerIndex: 1,
            explanation:
                'La prevención se centra en la igualdad, el respeto y la no tolerancia a la violencia.',
          ),
          Question(
            id: 'L5',
            categoryId: 'L348',
            question:
                '¿Cuál de estas situaciones podría considerarse violencia económica?',
            options: [
              'Acuerdo voluntario de gastos',
              'Controlar o impedir el acceso al dinero de la pareja',
              'Ahorrar en conjunto',
              'Planificar un presupuesto familiar',
            ],
            correctAnswerIndex: 1,
            explanation:
                'Impedir o controlar injustificadamente los recursos de otra persona puede constituir violencia económica.',
          ),
        ];

      case 'FIN':
        return [
          Question(
            id: 'F1',
            categoryId: 'FIN',
            question: '¿Qué es lo primero para un buen manejo del dinero?',
            options: [
              'Gastar y luego ver',
              'Hacer un presupuesto y registrar gastos',
              'Solo ahorrar si “sobra”',
              'Pedir créditos sin comparar',
            ],
            correctAnswerIndex: 1,
            explanation:
                'Presupuestar y llevar registro te permite decidir con datos: cuánto ahorrar, pagar y gastar.',
          ),
          Question(
            id: 'F2',
            categoryId: 'FIN',
            question: '¿Qué es el interés compuesto al ahorrar?',
            options: [
              'Interés que solo se calcula sobre el capital inicial',
              'Interés sobre capital + intereses acumulados',
              'Un cargo por usar la app',
              'Una comisión fija mensual',
            ],
            correctAnswerIndex: 1,
            explanation:
                'El interés compuesto hace crecer tu ahorro más rápido, porque “gana intereses sobre intereses”.',
          ),
          Question(
            id: 'F3',
            categoryId: 'FIN',
            question:
                '¿Qué porcentaje mínimo de tus ingresos se recomienda ahorrar de forma constante (regla simple)?',
            options: ['1–2%', '5–10%', '40–50%', '90%'],
            correctAnswerIndex: 1,
            explanation:
                'Una guía común es empezar con 5–10% de forma constante e incrementar cuando sea posible.',
          ),
          Question(
            id: 'F4',
            categoryId: 'FIN',
            question: 'Para reducir deudas, ¿qué acción es más efectiva?',
            options: [
              'Pagar solo el mínimo',
              'Refinanciar a menor tasa y priorizar deudas caras',
              'Ignorar los intereses',
              'Endeudarse más para pagar deudas',
            ],
            correctAnswerIndex: 1,
            explanation:
                'Bajar tasa y priorizar las de mayor costo reduce intereses totales y acelera la salida de deuda.',
          ),
          Question(
            id: 'F5',
            categoryId: 'FIN',
            question:
                '¿Qué hábito mejora la salud financiera con una billetera digital?',
            options: [
              'No revisar movimientos',
              'Usar reportes, metas de ahorro y alertas',
              'Compartir tu PIN para “ayuda”',
              'Hacer compras por impulso',
            ],
            correctAnswerIndex: 1,
            explanation:
                'Aprovechar reportes y metas te da control y previene gastos innecesarios.',
          ),
        ];

      case 'YASTA':
        return [
          Question(
            id: 'Y1',
            categoryId: 'YASTA',
            question: '¿Cuál es un uso común de una billetera como Yasta?',
            options: [
              'Pagar con QR y hacer transferencias',
              'Solo ver noticias',
              'Minar criptomonedas',
              'Hacer llamadas',
            ],
            correctAnswerIndex: 0,
            explanation:
                'Las billeteras digitales permiten pagos por QR, transferencias y recargas, entre otros.',
          ),
          Question(
            id: 'Y2',
            categoryId: 'YASTA',
            question:
                'Para aprovechar promociones y recompensas en Yasta Forest (tu juego), ¿qué ayuda más?',
            options: [
              'No usar la app',
              'Usar transferencias, encuestas y misiones para ganar puntos',
              'Esperar únicamente sorteos',
              'Desinstalar la app cada mes',
            ],
            correctAnswerIndex: 1,
            explanation:
                'El ecosistema premia el uso activo: transacciones, encuestas y misiones suman puntos.',
          ),
          Question(
            id: 'Y3',
            categoryId: 'YASTA',
            question:
                '¿Cómo se conectan los puntos con las recompensas en tu juego?',
            options: [
              'Los puntos no sirven',
              'Puntos → Monedas Yasta → cupones, donaciones y árboles de mayor rareza',
              'Directo a efectivo siempre',
              'Solo decoraciones sin valor',
            ],
            correctAnswerIndex: 1,
            explanation:
                'El flujo es: ganar puntos, convertir a monedas y canjear por beneficios o árboles que producen más puntos.',
          ),
          Question(
            id: 'Y4',
            categoryId: 'YASTA',
            question: 'Un “dato curioso” del juego es que el usuario puede:',
            options: [
              'Plantar árboles reales con aliados y recibir certificado digital',
              'Cambiar puntos por impuestos',
              'Usar monedas para llamadas',
              'Vender PIN a terceros',
            ],
            correctAnswerIndex: 0,
            explanation:
                'Tu mejora propone canjear monedas por un “Árbol Real”: foto, ubicación y certificado verificable.',
          ),
          Question(
            id: 'Y5',
            categoryId: 'YASTA',
            question: 'Para que Yasta sea útil día a día, lo clave es:',
            options: [
              'Que nadie más la use',
              'Tener comercios y amigos que acepten pagos/transferencias',
              'Usarla solo una vez al año',
              'No hacer recargas',
            ],
            correctAnswerIndex: 1,
            explanation:
                'La adopción crece cuando el entorno acepta la billetera: comercios, pares y casos de uso frecuentes.',
          ),
        ];

      case 'SEG':
        return [
          Question(
            id: 'S1',
            categoryId: 'SEG',
            question:
                '¿Qué práctica básica de seguridad debes seguir con tu billetera?',
            options: [
              'Compartir PIN/contraseña con familiares',
              'Usar PIN/biometría y no compartir credenciales',
              'Anotar el PIN en la parte trasera del celular',
              'Reutilizar la misma clave en todo',
            ],
            correctAnswerIndex: 1,
            explanation:
                'Nunca compartas credenciales. Usa PIN/biometría y claves distintas.',
          ),
          Question(
            id: 'S2',
            categoryId: 'SEG',
            question: 'Una señal típica de intento de estafa (phishing) es:',
            options: [
              'Un enlace sospechoso pidiendo tu PIN o código',
              'Un mensaje de tu contacto habitual sin enlaces',
              'Una notificación de la app oficial sin pedir datos',
              'Un comprobante de pago ya recibido',
            ],
            correctAnswerIndex: 0,
            explanation:
                'Desconfía de enlaces que solicitan claves o códigos. Verifica el canal oficial.',
          ),
          Question(
            id: 'S3',
            categoryId: 'SEG',
            question: 'Si pierdes tu celular, ¿qué es lo más adecuado?',
            options: [
              'No hacer nada y esperar',
              'Bloquear sesión, cambiar contraseñas y avisar soporte',
              'Publicarlo solo en redes',
              'Dar tu PIN a alguien “de soporte” por chat',
            ],
            correctAnswerIndex: 1,
            explanation:
                'Actúa rápido: bloquea sesión, cambia claves y contacta soporte por canales oficiales.',
          ),
          Question(
            id: 'S4',
            categoryId: 'SEG',
            question: '¿Cuál es una buena práctica para evitar fraudes con QR?',
            options: [
              'Escanear cualquier QR sin revisar',
              'Verificar el comercio/destinatario y monto antes de confirmar',
              'Confirmar con los ojos cerrados',
              'Pagar a quien te diga por teléfono',
            ],
            correctAnswerIndex: 1,
            explanation:
                'Siempre verifica destinatario y monto antes de confirmar un pago.',
          ),
          Question(
            id: 'S5',
            categoryId: 'SEG',
            question: 'Las apps desactualizadas pueden ser riesgosas porque:',
            options: [
              'Son más bonitas',
              'Pueden carecer de parches de seguridad recientes',
              'Consumen menos batería',
              'No tienen errores',
            ],
            correctAnswerIndex: 1,
            explanation:
                'Mantener la app actualizada reduce vulnerabilidades y mejora la seguridad.',
          ),
        ];

      default:
        // Fallback por si llega una categoría no contemplada
        return [
          Question(
            id: 'D1',
            categoryId: categoryId,
            question: 'Categoría no disponible. ¿Quieres volver a intentar?',
            options: ['Sí', 'No', 'Más tarde', 'Ayuda'],
            correctAnswerIndex: 0,
            explanation:
                'Selecciona una categoría válida desde la pantalla principal.',
          ),
        ];
    }
  }

  void selectAnswer(int index) {
    if (answered) return;
    final questions = getQuestionsForCategory(widget.category.id);

    setState(() {
      selectedAnswerIndex = index;
      answered = true;
      if (index == questions[currentQuestionIndex].correctAnswerIndex) {
        correctAnswers++;
      }
    });
  }

  void nextQuestion() {
    final questions = getQuestionsForCategory(widget.category.id);
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswerIndex = null;
        answered = false;
      });
    } else {
      context.go(
        '/quiz/results',
        extra: {
          'category': widget.category,
          'correctAnswers': correctAnswers,
          'totalQuestions': questions.length,
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final questions = getQuestionsForCategory(widget.category.id);
    final question = questions[currentQuestionIndex];
    final progress = (currentQuestionIndex + 1) / questions.length;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 🎨 Fondo decorativo
          Positioned(
            top: -230,
            right: -45,
            child: Container(
              width: 500,
              height: 500,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 0, 0, 0),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Column(
            children: [
              // 📊 Progreso
              QuizProgressIndicator(
                currentQuestion: currentQuestionIndex + 1,
                totalQuestions: questions.length,
                progress: progress,
                color: widget.category.color,
              ),

              // 📜 Contenido
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // 🏷️ Título + círculo
                      Column(
                        children: [
                          Text(
                            widget.category.name,
                            style: const TextStyle(
                              color: Color(0xFFFFB300),

                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFFFFB300),
                                width: 3,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                '${currentQuestionIndex + 1}',
                                style: const TextStyle(
                                  color: Color(0xFFFFB300),
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // ❓ Pregunta
                      Container(
                        padding: const EdgeInsets.all(20),
                        constraints: const BoxConstraints(minHeight: 150),
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B3A9).withOpacity(0.85),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          question.question,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // 🔘 Opciones
                      ...List.generate(
                        question.options.length,
                        (index) => Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: OptionButton(
                            option: question.options[index],
                            index: index,
                            isCorrect: index == question.correctAnswerIndex,
                            selectedAnswerIndex: selectedAnswerIndex,
                            answered: answered,
                            onTap: () => selectAnswer(index),
                          ),
                        ),
                      ),

                      // 💡 Explicación
                      if (answered) ...[
                        const SizedBox(height: 24),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color:
                                selectedAnswerIndex ==
                                    question.correctAnswerIndex
                                ? const Color(0xFFE8F5E9)
                                : const Color(0xFFFFF3E0),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color:
                                  selectedAnswerIndex ==
                                      question.correctAnswerIndex
                                  ? Colors.green
                                  : Colors.orange,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    selectedAnswerIndex ==
                                            question.correctAnswerIndex
                                        ? Icons.check_circle
                                        : Icons.info_outline,
                                    color:
                                        selectedAnswerIndex ==
                                            question.correctAnswerIndex
                                        ? Colors.green
                                        : Colors.orange,
                                    size: 24,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    selectedAnswerIndex ==
                                            question.correctAnswerIndex
                                        ? '¡Correcto!'
                                        : 'Respuesta incorrecta',
                                    style: TextStyle(
                                      color:
                                          selectedAnswerIndex ==
                                              question.correctAnswerIndex
                                          ? Colors.green
                                          : Colors.orange,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Text(
                                question.explanation,
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontSize: 14,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              // ➡️ Botón siguiente
              if (answered)
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(
                    onPressed: nextQuestion,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.category.color,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                      elevation: 0,
                    ),
                    child: Text(
                      currentQuestionIndex < questions.length - 1
                          ? 'Siguiente pregunta'
                          : 'Ver resultados',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
