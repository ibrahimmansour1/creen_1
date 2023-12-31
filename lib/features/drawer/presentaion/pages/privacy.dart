import 'package:creen/core/utils/functions/helper_functions.dart';
import 'package:creen/core/utils/responsive/sizes.dart';
import 'package:creen/core/utils/widgets/custom_appbar.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PrivacyScreen extends ConsumerWidget {
  const PrivacyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(Sizes.screenHeight() * 0.08),
          child: const CustomAppBar(
            back: true,
            title: 'privacy_policy',
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
                    _privacy[HelperFunctions.currentLanguage],
                  ),
                ),
              )),
        ),
      ),
    );
  }
}

Map<String, dynamic> _privacy = {
  "ar":
      '''نريدك في شركة كرين أن تكون على دراية بالمعلومات التي نجمعها وكيفية قيامنا باستخدامها ومشاركتها. ولذلك نشجعك على قراءة سياسة الخصوصية. ويساعدك ذلك على استخدام منتجات كرين بالطريقة المناسبة لك.
في سياسة الخصوصية، نوضح كيف نجمع المعلومات ونستخدمها ونشاركها ونحتفظ بها وننقلها. ونتيح لك أيضًا معرفة حقوقك. يتضمن كل قسم من السياسة أمثلة مفيدة ويستخدم لغة أبسط ليسهل عليك فهم ممارساتنا. وقد أضفنا أيضًا روابط إلى موارد تتيح لك التعرف على المزيد عن موضوعات الخصوصية التي تهمك.

ماذا إذا لم تسمح لنا بجمع معلومات معينة؟
بعض المعلومات ضرورية لعمل منتجاتنا. بعض المعلومات الأخرى اختيارية، ولكن حال عدم توفرها، فقد تتأثر جودة تجربتك.

نستخدم  لنوفر لك تجربة ذات طابع شخصي، بما في ذلك الإعلانات، إلى جانب الأغراض الأخرى التي نوضحها تفصيليًا فيما يلي.
بالنسبة إلى بعض هذه الأغراض، نستخدم المعلومات  و. وتتم معالجة المعلومات التي نستخدمها لهذه الأعراض تلقائيًا من خلال أنظمتنا. ولكن في بعض الحالات، نستخدم أيضًا  للوصول إلى معلوماتك ومراجعتها.
لتقليل استخدام المعلومات المرتبطة بالمستخدمين الفرديين، نلجأ في بعض الحالات إلى إزالة معلومات تحديد الهوية أو وضع المعلومات في صيغة مجمعة. قد نعمل أيضًا على إخفاء هوية المعلومات بحيث لا تحدد هويتك بعد ذلك. ونستخدم هذه المعلومات بالطرق نفسها التي نستخدم بها معلوماتك كما هو موضح في هذا القسم.

 لتعزيز السلامة والأمان والنزاهة
نستخدم المعلومات التي نجمعها للمساعدة على حماية الأشخاص من التعرض للضرر وتوفير منتجات تتسم بالأمان والسلامة.

كيف نستخدم معلوماتك؟

نستخدم  لنوفر لك تجربة ذات طابع شخصي، بما في ذلك الإعلانات، إلى جانب الأغراض الأخرى التي نوضحها تفصيليًا فيما يلي.
بالنسبة إلى بعض هذه الأغراض، نستخدم المعلومات  و. وتتم معالجة المعلومات التي نستخدمها لهذه الأعراض تلقائيًا من خلال أنظمتنا. ولكن في بعض الحالات، نستخدم أيضًا  للوصول إلى معلوماتك ومراجعتها.
لتقليل استخدام المعلومات المرتبطة بالمستخدمين الفرديين، نلجأ في بعض الحالات إلى إزالة معلومات تحديد الهوية أو وضع المعلومات في صيغة مجمعة. قد نعمل أيضًا على إخفاء هوية المعلومات بحيث لا تحدد هويتك بعد ذلك. ونستخدم هذه المعلومات بالطرق نفسها التي نستخدم بها معلوماتك كما هو موضح في هذا القسم.
فيما يلي طرق استخدام معلوماتك:

لتعزيز السلامة والأمان والنزاهة
نستخدم المعلومات التي نجمعها للمساعدة على حماية الأشخاص من التعرض للضرر وتوفير منتجات تتسم بالأمان والسلامة.

لتوفير خدمات القياس والتحليلات وخدمات الأنشطة التجارية
يلجأ الكثير من الأشخاص إلى منتجاتنا لتشغيل أنشطتهم التجارية أو ترويجها. ونحن نساعدهم على قياس أداء إعلاناتهم وأشكال المحتوى الأخرى.

للتواصل معك
نتواصل معك باستخدام المعلومات التي قدمتها لنا، مثل معلومات الاتصال التي أدخلتها في ملفك الشخصي.

لإجراء الأبحاث والابتكار من أجل الأعمال الخيرية
نستخدم ما لدينا من معلومات، إلى جانب المعلومات الواردة من الباحثين ومجموعات البيانات من المصادر المتاحة بشكل علني، والمجموعات المتخصصة والمجموعات غير الهادفة للربح لإجراء الأبحاث ودعمها.

كيف نشارك المعلومات مع الشركاء والموّردين وموفري الخدمات والجهات الخارجية؟

لا نبيع أيًا من معلوماتك إلى أي شخص، ولن يحدث هذا 

حالات أخرى نشارك فيها المعلومات مع جهات خارجية
نشارك المعلومات مع جهات خارجية استجابة للطلبات القانونية أو امتثالاً للقوانين السارية أو منعًا للضرر. .
وإذا كنا نبيع أو ننقل كل أو جزء من نشاطنا التجاري لجهة أخرى، فقد نقدم معلوماتك للمالك الجديد كجزء من الصفقة، تمشيًا مع القانون الساري.

ما المدة الزمنية التي نحتفظ فيها بمعلوماتك؟
نحتفظ بالمعلومات طالما كنا نحتاج إليها لتوفير منتجاتنا، أو الامتثال للالتزامات القانونية أو حماية مصالحنا أو مصالح الآخرين. ونقرر المدة التي نحتاج فيها إلى المعلومات لكل حالة على حدة. فيما يلي الاعتبارات التي نراعيها عند تحديد مدة الاحتفاظ بالمعلومات:
الحاجة إليها لتشغيل منتجاتنا أو توفيرها. على سبيل المثال، نحتاج إلى الاحتفاظ ببعض معلوماتك للإبقاء على حسابك. .
الميزة التي نستخدم فيها المعلومات، والطريقة التي تعمل بها هذه الميزة. على سبيل المثال، يتم الاحتفاظ بالرسائل التي يتم إرسالها باستخدام وضع الاختفاء في كرين لمدة أقل من الرسائل العادية. .
المدة التي نحتاج إلى الاحتفاظ بالمعلومات فيها امتثالاً لبعض الالتزامات القانونية. .
مدى احتياجنا لتلك المعلومات في أغراض مشروعة أخرى، مثل منع الضرر؛ والتحقيق في الانتهاكات المحتملة لشروطنا أو سياساتنا؛ ونشر السلامة، والأمان والنزاهة؛ أو حماية أنفسنا، بما في ذلك حقوقنا أو ممتلكاتنا أو منتجاتنا.

كيف نستجيب للطلبات القانونية، ونمتثل للقوانين المعمول بها ونمنع الضرر؟
نصل إلى معلوماتك ونحتفظ بها ونستخدمها ونشاركها في الحالات التالية:
استجابة للطلبات القانونية، مثل مذكرات التفتيش، أو الأوامر القضائية، أو أوامر تقديم المستندات أو مذكرات الاستدعاء. ترد هذه الطلبات من جهات خارجية مثل المتقاضين المدنيين وجهات إنفاذ القانون والسلطات الحكومية الأخرى.  عن الحالات التي نستجيب فيها للطلبات القانونية.
وفقًا للقانون المعمول به
تعزيزًا لسلامة وأمان ونزاهة منتجات كرين ومستخدميها وموظفيها وممتلكاتها والعامة. .
يجوز لنا الوصول إلى معلوماتك أو الاحتفاظ بها لمدة زمنية طويلة. .

كيف تعرف أن السياسة قد تغيرت؟
سنخطرك قبل إجراء تغييرات جوهرية على هذه السياسة. ستتوفر لك فرصة مراجعة السياسة المنقحة قبل أن تقرر مواصلة استخدام منتجاتنا.






''',
  "en":
      '''At Creen, we want you to be aware of what information we collect and how we use and share it. We therefore encourage you to read the Privacy Policy. This helps you use Creen products in the right way for you.
In this Privacy Policy, we explain how we collect, use, share, maintain and transfer information. We also let you know your rights. Each section of the policy includes helpful examples and uses simpler language to make our practices easier for you to understand. We've also added links to resources that let you learn more about privacy topics of interest to you.

What if you do not allow us to collect certain information?
Some information is necessary for the functioning of our products. Some other information is optional, but if it is not available, the quality of your experience may be affected.

We use it to provide you with a personalized experience, including advertising, as well as for other purposes that we detail below.
For some of these purposes, we use information and. The information we use for these symptoms is automatically processed by our systems. But in some cases, we also use it to access and review your information.
To reduce the use of information associated with individual users, in some cases we remove identifying information or put the information in an aggregated form. We may also anonymize the information so that it no longer identifies you. We use this information in the same ways we use your information as described in this section.

  To promote safety, security and integrity
We use the information we collect to help protect people from harm and provide safe and secure products.

How do we use your information?

We use it to provide you with a personalized experience, including advertising, as well as for other purposes that we detail below.
For some of these purposes, we use information and. The information we use for these symptoms is automatically processed by our systems. But in some cases, we also use it to access and review your information.
To reduce the use of information associated with individual users, in some cases we remove identifying information or put the information in an aggregated form. We may also anonymize the information so that it no longer identifies you. We use this information in the same ways we use your information as described in this section.
Here are the ways we use your information:

To promote safety, security and integrity
We use the information we collect to help protect people from harm and provide safe and secure products.

To provide measurement, analytics, and business services
Many people use our products to run or promote their businesses. We help them measure the performance of their ads and other forms of content.

To communicate with you
We communicate with you using information you have provided us, such as the contact information you have entered in your profile.

To conduct research and innovation for philanthropy
We use our information, along with information from researchers and data sets from publicly available sources, professional groups and not-for-profit groups to conduct and support research.

How do we share information with partners, suppliers, service providers and third parties?

We do not sell any of your information to anyone, nor will this happen

Other cases in which we share information with third parties
We share information with third parties in response to legal requests, to comply with applicable laws, or to prevent harm. .
If we sell or transfer all or a portion of our business to another party, we may provide your information to the new owner as part of the transaction, consistent with applicable law.

How long do we keep your information?
We keep information for as long as we need it to provide our products, comply with legal obligations or protect our interests or those of others. We decide how long we need the information on a case-by-case basis. The following are considerations when determining how long to retain information:
needed to operate or provide our products. For example, we need to keep some of your information to maintain your account. .
The feature in which we use the information, and the way that feature works. For example, messages sent using Creen's invisibility mode are kept for less than normal messages. .
How long we need to keep the information to comply with certain legal obligations. .
whether we need that information for other legitimate purposes, such as preventing harm; investigate potential violations of our terms or policies; promote safety, security and integrity; or protect ourselves, including our rights, property, or products.

How do we respond to legal requests, comply with applicable laws and prevent harm?
We access, keep, use and share your information when:
In response to legal requests, such as search warrants, court orders, document subpoenas or subpoenas. These requests come from third parties such as civil litigants, law enforcement, and other government authorities. About when we respond to legal requests.
In accordance with applicable law
To promote the safety, security, and integrity of Creen's products, users, employees, property, and the public. .
We may access or retain your information for an extended period of time. .

How do you know the policy has changed?
We will notify you before we make material changes to this policy. You will have an opportunity to review the revised Policy before you decide to continue using our Products.''',
};
