import 'package:flutter/material.dart';

import '../../../../core/utils/functions/helper_functions.dart';
import '../../../../core/utils/responsive/sizes.dart';
import '../../../../core/utils/widgets/custom_appbar.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(Sizes.screenHeight() * 0.08),
          child: const CustomAppBar(
            back: true,
            title: 'terms_and_conditions',
          )),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.black, Colors.black45],
                  begin: Alignment.topRight,
                  end: Alignment.topLeft,
                  tileMode: TileMode.clamp)),
          child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)),
              ),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: Sizes.screenHeight() * 0.05,
                      horizontal: Sizes.screenWidth() * 0.06),
                  child: Text(
                    _terms[HelperFunctions.currentLanguage],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}

Map<String, dynamic> _terms = {
  "ar": '''1. الخدمات التي نوفرها
تتمثل مهمتنا في تعزيز قدرة الأشخاص على بناء المجتمعات والتعاون من أجل تقريب المسافات. وللمضي قدمًا لتحقيق هذه المهمة، نقدم لك المنتجات والخدمات الموضّحة أدناه:
تقديم تجربة ذات طابع شخصي لك:
تختلف تجربتك على كرين عن تجربة أي شخص آخر: بدءًا من المنشورات والفيديوهات والإعلانات وغيرها من أنواع المحتوى الأخرى التي تظهر لك في آخر أخبار كرين أو منصة الفيديو التي نوفرها، والميزات الأخرى التي قد تستخدمها. على سبيل المثال، نستخدم البيانات المتوفرة لدينا، مثل تلك المتعلقة بعمليات التواصل التي تقوم بها والاختيارات والإعدادات التي تحددها والعناصر التي تقوم بمشاركتها والإجراءات التي تتخذها داخل منتجاتنا وخارجها - لإضفاء طابع شخصي على تجربتك.
توفير إمكانية التواصل مع الأشخاص:
نساعدك في العثور على الأشخاص والمجموعات وغيرها مما يقع ضمن دائرة اهتماماتك والتواصل معها عبر منتجات كرين التي تستخدمها. تُعد الروابط القوية أساسًا مهمًا لبناء مجتمعات أفضل، ونحن على يقين أن خدماتنا تصبح أكثر فائدة عندما يتواصل الأشخاص معًا ومع المجموعات التي يهتمون بها.
تمكينك من التعبير عن نفسك والتواصل بشأن ما يهمّك:
نوفر لك العديد من الطرق للتعبير عن نفسك على كرين للتواصل مع الأصدقاء وأفراد العائلة والأشخاص الآخرين بخصوص الأمور التي تهتم بها - على سبيل المثال، مشاركة تحديثات الحالة والصور ومقاطع الفيديو والقصص ،  أو إنشاء مجموعات، أو إضافة محتوى إلى ملفك الشخصي بالإضافة إلى إطلاعك على رؤى عن كيفية تفاعل الآخرين مع المحتوى الذي تقدمه. ولقد قمنا أيضًا بتطوير، ولا نزال نكتشف، وسائل جديدة تتيح للأشخاص إمكانية استخدام التكنولوجيا.
مساعدتك في استكشاف المحتوى والمنتجات والخدمات التي قد تهتم بها:
نعرض عليك إعلانات وعروض وغيرها من أنواع المحتوى المُموَّل أو التجاري الذي يحمل الطابع الشخصي لمساعدتك في التعرف على عناصر المحتوى والمنتجات والخدمات التي تقدمها العديد من الأنشطة التجارية والمنظمات التي تستخدم كرين.
تعزيز سلامة وأمان ونزاهة خدماتنا، ومكافحة السلوك الضار والحفاظ على سلامة مستخدمي مجتمعنا:
لن يتمكن الأشخاص من بناء مجتمع على منتجات  كرين إلا عند الشعور بالأمان والسلامة. نعمل جاهدين للحفاظ على أمان (بما في ذلك التوّفر والأصالة والنزاهة والسرية) منتجاتنا وخدماتنا. ولذا نطور أنظمة تقنية متقدمة لاكتشاف حالات إساءة الاستخدام المحتملة لمنتجاتنا والسلوكيات الضارة تجاه الآخرين والمواقف التي يمكننا تقديم المساعدة خلالها تجاه دعم وحماية مجتمعنا، بما في ذلك الرد على بلاغات المستخدمين حول المحتوى الذي يحتمل أن يكون مخالفًا. فإذا نما إلى علمنا وجود مثل هذا المحتوى أو السلوك، يجوز لنا اتخاذ الإجراء المناسب استنادًا إلى تقييمنا الذي قد يشمل إخطارك، أو عرض تقديم مساعدة، أو إزالة المحتوى، أو إزالة أو حجب الوصول إلى ميزات محددة، أو تعطيل الحساب، أو التواصل مع جهات إنفاذ القانون. يجوز لشركة كرين الوصول إلى أي معلومات تجمعها عنك وحفظها واستخدامها ومشاركتها عندما يتوفر لديها اعتقاد بحسن نية بضرورة القيام بذلك أو أن القانون يجيز لها القيام بذلك. للحصول على مزيد من المعلومات، يرجى مراجعة سياسة الخصوصية.

البحث عن طرق لتحسين خدماتنا على نحو أفضل:
نهتم بإجراء الأبحاث لتطوير منتجاتنا واختبارها وتحسينها. ويتضمن ذلك تحليل البيانات المتوفرة لدينا والتعرف على طبيعة استخدام الأشخاص لمنتجاتنا، على سبيل المثال من خلال إجراء استبيانات وإجراء اختبارات على ميزات جديدة واكتشاف المشكلات وحلها. توضح سياسة الخصوصية التي نتبعها كيفية استخدامنا للبيانات لدعم عمليات البحث هذه لأغراض تطوير خدماتنا وتحسينها.
ضمان الوصول إلى خدماتنا:
حتى نتمكن من تقديم خدمتنا على مستوى العالم وتمكينك من التواصل مع الأشخاص في جميع أنحاء العالم، نحتاج إلى نقل المحتوى والبيانات وتخزينها وتوزيعها في أنظمة ومراكز البيانات ، وموفري الخدمات الذين نتعامل معهم وموردينا في جميع أنحاء العالم، بما في ذلك تلك التي تقع خارج بلد إقامتك. يكون استخدام هذه البنية الأساسية العالمية مطلوبًا وضروريًا لتقديم خدماتنا. 
3. التزاماتك تجاه كرين ومجتمعنا
نقدم هذه الخدمات لك وللآخرين للمساعدة في المضي قدمًا لتحقيق مهمتنا. وفي المقابل، نريد منك الالتزام بما يلي:
1. مَن الذي يمكنه استخدام كرين
عندما يدعم الأشخاص آراءهم وأفعالهم، يعم مجتمعنا شعور أكثر بالأمان والمسؤولية. ولهذا السبب، يجب عليك:
•	تسمية حسابك بنفس الاسم الذي تستخدمه في حياتك اليومية.
•	تقديم معلومات دقيقة عن نفسك.
•	إنشاء حساب واحد فقط واستخدامه للأغراض الشخصية فقط.
•	عدم مشاركة كلمة السر أو منح صلاحية الوصول إلى حسابك على كرين إلى الآخرين أو نقل حسابك إلى أي شخص آخر (دون الحصول على إذن منا).
نسعى دائمًا إلى تمكين جميع الأشخاص بصفة عامة من استخدام كرين، إلا أنه لا يمكنك استخدام كرين في الحالات التالية:
•	إذا كان عمرك أقل 13 سنة.
•	إذا تمت إدانتك في جريمة تحرش أو اعتداء جنسي.
•	إذا كنا قد قمنا بتعطيل حسابك في وقت سابق بسبب انتهاكه لشروطنا، أو معايير المجتمع، أو أي شروط وسياسات أخرى تسري على استخدامك لكرين. إذا قمنا بتعطيل حسابك بسبب انتهاكه لشروطنا أو معايير المجتمع، أو أي شروط وسياسات أخرى، فإنك توافق على عدم قيامك بإنشاء حساب آخر من دون الحصول على إذن منا. يتم منح الإذن لإنشاء حساب جديد وفقًا لتقديرنا الخاص، ولا يعني أو يشير ضمنًا إلى أن الإجراء التأديبي كان خطأً أو بلا سبب.
•	إذا كنت من ضمن المشمولين بحظر تلقي منتجاتنا أو خدماتنا أو برامجنا بموجب القوانين المعمول بها.
2. ما الذي يمكنك مشاركته والقيام به في كرين
نريد أن يستخدم الأشخاص كرين للتعبير عن أنفسهم ومشاركة المحتوى الذي يهمهم، ولكن دون أن يكون ذلك على حساب أمان وسلامة الآخرين أو على حساب نزاهة مجتمعنا. ولذلك أنت توافق على عدم ارتكاب أي من السلوكيات الموضّحة أدناه (أو تسهيل ذلك للآخرين أو مساعدتهم في ارتكابه):
1.	لا يجوز لك استخدام منتجاتنا للقيام بأي شيء أو مشاركة أي شيء:
•	ينتهك هذه الشروط أو معايير المجتمع أو غيرها من الشروط والسياسات الأخرى التي تسري على استخدامك لمنتجاتنا.
•	غير قانوني أو مضلل أو تمييزي أو احتيالي (أو يساعد شخصًا آخر في استخدام منتجاتنا بهذه الطريقة).
•	لا تملكه أو لا تملك الحقوق الضرورية لمشاركته.
•	ينتهك أو يخالف حقوق شخص آخر، بما في ذلك حقوق الملكية الفكرية لهذا الشخص (مثل انتهاك حقوق النشر أو العلامة التجارية لشخص آخر، أو توزيع أو بيع سلع مزيفة أو مقرصنة)، ما لم ينطبق استثناء أو قيد بموجب القانون المعمول به.
2.	لا يجوز لك تحميل الفيروسات، أو الرموز البرمجية الضارة، أو استخدام الخدمات لإرسال محتوى غير مهم أو احتيالي، أو القيام بأي شيء آخر من شأنه تعطيل أو عرقلة أو التعارض مع أو إعاقة تشغيل خدماتنا أو أنظمتنا أو منتجاتنا على النحو المناسب أو عملها أو نزاهتها أو ظهورها بالشكل المناسب.
3.	لا يجوز لك الوصول إلى البيانات أو جمعها من منتجاتنا باستخدام وسائل تلقائية (دون الحصول على إذن مسبق منّا) أو محاولة الوصول إلى بيانات لا تملك صلاحية الوصول إليها.
4.	لا يجوز لك تمرير أو طلب أو جمع أسماء مستخدمي المنتج أو كلمات السر أو الاستيلاء على رموز الوصول.
5.	لا يجوز لك بيع أو ترخيص أو شراء أي بيانات يتم الحصول عليها من جانبنا أو من خدماتنا، باستثناء ما هو منصوص عليه في شروط المنصة.
6.	لا يجوز لك إساءة استخدام أي قناة من قنوات الإبلاغ أو التمييز أو النزاع أو الطعن، كأن يتم ذلك على سبيل المثال من خلال تقديم بلاغات أو طعون احتيالية أو مكررة أو لا أساس لها.
يمكننا إزالة أو حجب الوصول إلى المحتوى الذي ينتهك هذه الأحكام. يمكننا أيضًا تعليق حسابك أو تعطيله بسبب سلوك ينتهك هذه الأحكام.
إذا أزلنا المحتوى الذي شاركته نتيجة لانتهاكه لمعايير المجتمع، فسنخطرك بذلك ونوضح لك أي خيارات متوفرة لك لطلب المراجعة، ما لم تقم بانتهاك هذه الشروط بشكل خطير أو متكرر؛ أو إذا كان القيام بذلك يعرضنا نحن أو غيرنا للمسؤولية القانونية؛ أو يلحق الضرر بمجتمع مستخدمينا؛ أو يعرض أمان أي من خدماتنا أو أنظمتنا أو منتجاتنا للخطر أو يؤدي إلى إعاقة تشغيلها؛ أو عندما لا نتمكن من التعامل مع الأمور بالشكل المطلوب بسبب قيود فنية؛ أو في الحالات التي يحظر علينا القيام بذلك لأسباب قانونية. 
للمساعدة في دعم مجتمعنا، نشجعك على الإبلاغ عن أي محتوى أو سلوك تعتقد أنه يمثل انتهاكًا لحقوقك .







3. الأذونات التي تمنحها لنا
نطلب منك منحنا أذونات محددة حتى نتمكن من تقديم خدماتنا:
1.	إذن استخدام المحتوى الذي تقوم بإنشائه ومشاركته: قد تكون بعض عناصر المحتوى التي تقوم بمشاركتها أو تحميلها، مثل الصور أو مقاطع الفيديو، محمية بموجب قوانين الملكية الفكرية.
تحتفظ بملكيتك لحقوق الملكية الفكرية (حقوق مثل حقوق النشر أو حقوق العلامات التجارية) لأي محتوى تقوم بإنشائه ومشاركته على كرين. لا يوجد في هذه الشروط ما يحرمك من حقوقك في المحتوى الخاص بك. لك مطلق الحرية في مشاركة المحتوى الخاص بك مع أي شخص آخر، في أي مكان تريده.
ومع ذلك، حتى نتمكن من تقديم خدماتنا، نطلب منك أن تمنحنا بعض الأذونات القانونية (المعروفة باسم "الترخيص") التي تخول لك استخدام هذا المحتوى. يتعلق هذا الأمر فقط بأغراض توفير وتحسين منتجاتنا وخدماتنا .
على وجه التحديد، عندما تقوم بمشاركة محتوى محمي بموجب حقوق الملكية الفكرية أو نشره أو تحميله على أو في منتجاتنا أو بأي طريقة ذات صلة بمنتجاتنا، فإنك بذلك تمنحنا ترخيصًا دوليًا غير حصري، قابلاً للنقل، وقابلاً للترخيص من الباطن، وغير محفوظ الحقوق، لاستضافة المحتوى، واستخدامه، وتوزيعه، وتعديله، وتشغيله، ونسخه، وتقديمه أو عرضه على العامة، وترجمته، وإنشاء أعمال مشتقة منه (بما يتوافق مع إعدادات الخصوصية والتطبيق الخاصة بك). ذلك يعني أنه، على سبيل المثال، إذا قمت بمشاركة صورة على كرين، فإنك بذلك تمنحنا إذنًا يسمح لنا بتخزينها ونسخها ومشاركتها مع الآخرين (ونكرر، بما يتوافق مع إعداداتك) .تنتهي صلاحية هذا الترخيص عندما يتم حذف المحتوى الخاص بك من أنظمتنا.
يمكنك حذف المحتوى الفردي الذي تشاركه وتنشره وتحمله في أي وقت. بالإضافة إلى ذلك، سيتم حذف كل المحتوى المنشور على حسابك الشخصي إذا قمت بحذف حسابك. لا يؤدي حذف الحساب تلقائيًا إلى حذف المحتوى الذي تنشره كمسؤول لصفحة أو محتوى تقوم بإنشائه بشكل جماعي مع مستخدمين آخرين، مثل الصور الموجودة في ألبومات مشتركة والتي قد تظل مرئية للأعضاء الآخرين المساهمين في الألبوم.
2.	إذن استخدام اسمك وصورة ملفك الشخصي والمعلومات المتعلقة بالإجراءات التي تتخذها فيما يتعلق بالإعلانات والمحتوى التجاري: إنك تمنحنا إذنًا باستخدام اسمك وصورة ملفك الشخصي والمعلومات المتعلقة بالإجراءات التي اتخذتها على كرين بجوار أو في أي محتوى له صلة بالإعلانات والعروض وغيرها من عناصر المحتوى التجاري التي نعرضها عبر منتجاتنا، دون تقديم أي تعويض لك مقابل ذلك. 
3.	إذن تحديث البرنامج الذي تستخدمه أو تقوم بتنزيله: في حال تنزيل برنامجنا أو استخدامه، فأنت تمنحنا إذنًا بتنزيل التحديثات وتثبيتها على البرنامج كلما أمكن.
4. قيود استخدام حقوق ملكيتنا الفكرية
إذا كنت تستخدم عناصر محتوى محمية بموجب حقوق الملكية الفكرية التي نمتلكها ونوفرها عبر منتجاتنا (على سبيل المثال، الصور أو التصميمات أو مقاطع الفيديو أو المقاطع الصوتية التي نوفرها لك وتقوم أنت بإضافتها إلى محتوى تقوم بإنشائه ومشاركته على كرين)، فإننا نحتفظ بجميع الحقوق تجاه عناصر المحتوى هذه (ولكن لا نحتفظ بحقوق عناصر المحتوى الخاصة بك). ولا يمكنك إلا استخدام حقوق النشر أو حقوق العلامات التجارية (أو أية علامات مشابهة) الخاصة بنا وفقًا لما هو مسموح به صراحةً بموجب إرشادات استخدام العلامات التجارية الخاصة بنا أو بموجب إذن كتابي مسبق من طرفنا. يجب عليك الحصول على إذن كتابيّ منّا (أو إذن بموجب ترخيص مفتوح المصدر) حتى تتمكن من تعديل منتجاتنا أو مكوناتها أو ترجمتها إلى لغة أخرى أو إنشاء أعمال مشتقة منها أو إلغاء تجميعها أو عكس هندستها، أو محاولة استخراج رمز برمجي خاص بنا بأي طريقة، ما لم ينطبق استثناء أو قيد بموجب القانون المعمول به .


4. شروط إضافية
1. تحديث شروطنا
نسعى دائمًا إلى تحسين خدماتنا وتطوير ميزات جديدة لتصبح منتجاتنا أفضل وأكثر ملاءمة لك ولمجتمعنا. ونتيجة لذلك، فقد يتطلب الأمر تحديث هذه الشروط من وقت لآخر لتعبر عن خدماتنا وممارساتنا بدقة أكبر ولتقديم تجربة تتميز بالأمان والسلامة على منتجاتنا وخدماتنا، و/أو الامتثال للقانون المعمول به. لن نقوم بإجراء تغييرات إلا إذا لم تعد الأحكام مناسبة أو كانت غير مكتملة، وكانت التغييرات معقولة وتراعي مصالحك، أو إذا كانت التغييرات مطلوبة لأغراض السلامة والأمن أو للامتثال للقانون المعمول به.
سنقوم بإبلاغك (على سبيل المثال: عبر البريد الإلكتروني أو عبر منتجاتنا) قبل إجراء أي تغييرات على هذه الشروط بمدة لا تقل عن 30 يومًا ونمنحك فرصة لمراجعتها قبل أن تدخل حيّز التنفيذ، ما لم تكن التغييرات مطلوبة بموجب القانون. وبمجرد دخول أي شروط تم تحديثها حيز التنفيذ، يجب عليك الالتزام بها إذا قررت الاستمرار في استخدام منتجاتنا.
2. تعليق الحساب أو إنهاؤه
نريد أن يصبح كرين مكانًا يستطيع من خلاله الأشخاص التعبير عن أنفسهم ومشاركة أفكارهم وآرائهم بحرية وأمان تام.
إذا وجدنا، وفقًا لتقديرنا الخاص، أنك قمت بشكل واضح أو جدي أو متكرر بمخالفة شروطنا أو سياساتنا، بما في ذلك على وجه الخصوص معايير المجتمع، يجوز لنا تعليق صلاحية وصولك إلى منتجاتنا أو تعطيلها نهائيًا، ويجوز لنا تعطيل حسابك نهائيًا أو حذفه. يجوز لنا أيضًا تعطيل حسابك أو حذفه في حال تكرار انتهاكك لحقوق الملكية الفكرية لأشخاص آخرين أو إذا طُلب منا القيام بذلك لأسباب قانونية.
يجوز لنا تعطيل حسابك أو حذفه إذا لم يتم تأكيد حسابك بعد التسجيل، أو إذا لم يتم استخدام حسابك وظل غير نشط لفترة زمنية طويلة، أو إذا اكتشفنا أن شخصًا ما قد استخدمه دون الحصول على إذن منك ولم نتمكن من تأكيد ملكيتك للحساب. 
وعندما نتخذ مثل هذا الإجراء، سنخطرك بذلك ونوضح لك أي خيارات متوفرة لك لطلب مراجعة، إذا كان القيام بذلك يعرضنا نحن أو غيرنا للمسؤولية القانونية؛ أو يلحق الضرر بمجتمع مستخدمينا؛ أو يعرض نزاهة أي من خدماتنا أو أنظمتنا أو منتجاتنا للخطر أو يتعارض معها أو يؤدي إلى إعاقة تشغيلها؛ أو عندما لا نتمكن من التعامل مع الأمور بالشكل المطلوب بسبب قيود فنية؛ أو في الحالات التي يحظر علينا القيام بذلك لأسباب قانونية.
3. حدود المسؤولية
نعمل جاهدين لتقديم أفضل المنتجات فضلاً عن توفير إرشادات واضحة لكل من يستخدمها. وعلى الرغم من ذلك، فإن منتجاتنا تُقدم "كما هي"، وإلى الحد الذي يسمح به القانون، لا نُقدم أي ضمانات تجاه بقائها آمنة، محمية، أو خالية من الأخطاء، أو أنها ستعمل دون حالات تعطل أو تأخير أو حالات تشغيل غير مثالية. إلى الحد الذي يسمح به القانون، فإننا نخلي مسؤوليتنا أيضًا تجاه كل أنواع الضمانات، سواءً كانت صريحة أو ضمنية، بما في ذلك الضمانات الضمنية للرواج التجاري، والملاءمة لغرض معين، وعدم انتهاك الحقوق والملكية. نحن لا نتحكم أو نوجه الأشخاص والآخرين إلى ما يجب أن يفعلوه أو يقولوه، ولا نتحمل أي مسؤولية تجاه أفعالهم أو سلوكياتهم (سواء عبر الإنترنت أو في الواقع) أو أي محتوى يشاركونه (بما في ذلك أي محتوى مسيء أو غير ملائم أو فاحش أو غير قانوني، وغيرها من عناصر المحتوى المرفوضة).
لا يمكننا التنبؤ بالأوقات التي يمكن أن تحدث خلالها مشكلات تتعلق بمنتجاتنا. وفقًا لذلك، فإن مسؤوليتنا تقتصر على الحد الأقصى الذي يسمح به القانون المعمول به. إلى الحد الأقصى الذي يسمح به القانون المعمول به، لن نتحمل أي مسؤولية تحت أي ظرف من الظروف تجاه أي خسائر في الأرباح أو الإيرادات أو المعلومات أو البيانات أو أي أضرار تبعية أو خاصة أو غير مباشرة أو تحذيرية أو عقابية أو عارضة تنشأ عن أو ترتبط بهذه الشروط (مهما كان السبب وتحت أي مفهوم للمسئولية بما في ذلك الإهمال)، حتى وإن تم إبلاغنا باحتمالية وقوع مثل تلك الأضرار والخسائر.
4. النزاعات
نسعى جاهدين إلى توفير قواعد واضحة للحد من نشوب نزاعات بينك وبيننا، بل ومنعها تمامًا إن أمكن. وفي حالة نشوب نزاع، على الرغم من ذلك، فمن المفيد اكتساب معرفة مسبقة بأماكن حل هذا النزاع والقوانين التي تنطبق عليه.
إذا كنت مستهلكًا، تنطبق القوانين السارية في البلد محل إقامتك على أي دعوى أو سبب دعوى أو نزاع تقوم برفعه ضدنا، والذي ينشأ عن أو يرتبط بهذه الشروط ، ويجوز لك أيضًا تسوية النزاع في أي محكمة مختصة في ذلك البلد الذي تخضع هذه الدعوى لسلطته القضائية. في كل الحالات الأخرى، ولأي دعوى أو سبب دعوى أو نزاع ترفعه كرين ضدك، فإنك توافق أنت وكرين على تسوية أي دعوى أو سبب دعوى أو نزاع بشكل حصري أمام المحكمة الجزئية الأمريكية في المنطقة الشمالية من كاليفورنيا أو أمام محكمة الولاية الواقعة في مقاطعة سان ماتيو. وتوافق أيضًا على أن تخضع للسلطة القضائية الشخصية للمحاكم المذكورة أعلاه بغرض البت في جميع هذه الدعاوى، وأن هذه الشروط وأي دعوى أو سبب دعوى أو نزاع ستخضع للقوانين السارية في ولاية كاليفورنيا، دون اعتبار لتعارض أحكام القانون. دون الإخلال بما سبق، فإنك توافق على أنه يجوز لكرين وفق تقديرها المطلق تقديم أي دعوى أو سبب دعوى أو نزاع نود رفعه ضدك في أي محكمة مختصة في بلد إقامتك تقع هذه الدعوى ضمن سلطاتها القضائية.
تاريخ آخر مراجعة: 1 ابريل 2023


''',
  "en": '''1. Our services
Our mission is to empower people to build communities and collaborate to bridge distances. In furtherance of this mission, we offer you the products and services described below:
Provide you with a personalized experience:
Your experience on Creen is unlike anyone else's: from the posts, videos, ads, and other types of content you see in your Creen News Feed or our video platform, to other features you may use. For example, we use the data we have — such as about the communications you make, the choices and settings you make, the items you share, and the actions you take on and off our Products — to personalize your experience.
Providing the possibility to communicate with people:
We help you find and connect with people, groups and more that interest you through the Creen products you use. Strong connections are an important foundation for building better communities, and we know our services are even more useful when people connect with each other and with the groups they care about.
Enabling you to express yourself and communicate about what matters to you:
There are many ways for you to express yourself on Creen to connect with friends, family and other people about the things you care about - for example, share status updates, photos, videos and stories, create groups, add content to your profile and get insights How other people interact with your content. We have also developed, and continue to discover, new ways for people to use technology.
Helping you discover content, products and services you may be interested in:
We show you ads, offers, and other types of personalized sponsored or commercial content to help you learn about the content, products, and services of the many businesses and organizations that use Creen.
Promote the safety, security and integrity of our services, combat harmful behavior and keep our community users safe:
People will only be able to build a community on Creen products when they feel safe and secure. We work hard to maintain the security (including availability, authenticity, integrity, and confidentiality) of our products and services. That's why we develop advanced technology systems to detect potential misuse of our products, harmful behavior towards others, and situations where we can help support and protect our community, including responding to user reports about potentially offensive content. If we become aware of such content or behavior, we may take appropriate action based on our assessment which may include notifying you, offering assistance, removing the content, removing or blocking access to certain features, disabling the account, or contacting third parties. Law enforcement. Creen may access, store, use and share any information it collects about you when it has a good faith belief that it is necessary or is permitted by law to do so. For more information, please review the Privacy Policy.

Looking for ways to better improve our services:
We focus on research to develop, test and improve our products. This includes analyzing the data we have and learning about how people use our products, for example by taking surveys, testing new features and troubleshooting. Our Privacy Policy explains how we use data to support these searches for the purposes of developing and improving our Services.
Ensure access to our services:
In order for us to deliver our service globally and enable you to communicate with people around the world, we need to transfer, store and distribute content and data in systems and data centers, our service providers and our suppliers around the world, including those outside your country of residence . Use of this global infrastructure is required and necessary to provide our Services.
3. Your obligations to Creen and our community
We provide these services to you and others to help move us forward in our mission. In return, we want you to commit to the following:
1. Who can use a Creen?
When people support their opinions and actions, our society feels more secure and responsible. For this reason, you must:
• Give your account the same name that you use in your daily life.
• Provide accurate information about yourself.
• Create only one account and use it for personal purposes only.
• Do not share your password, grant access to your Creen account to others, or transfer your account to anyone else (without our permission).
We always strive to enable all people in general to use the Creen, but you cannot use the Creen in the following cases:
• If you are under 13 years old.
• If you have been convicted of sexual harassment or assault.
• If we have previously disabled your account for violating our Terms, Community Standards, or any other terms and policies applicable to your use of Creen. If we disable your account because it violates our Terms, the Community Standards, or any other terms and policies, you agree not to create another account without our permission. Permission to create a new account is granted at our sole discretion and does not mean or imply that the disciplinary action was wrong or without cause.
• If you are prohibited from receiving our products, services or software under applicable laws.
2. What can you share and do in Creen
We want people to use Creen to express themselves and share content that matters to them, but not at the expense of the safety and well-being of others or the integrity of our community. Therefore, you agree not to engage in (or facilitate or assist others) any of the behavior described below''',
};
