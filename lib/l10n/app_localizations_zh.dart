// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appVersion => '版本 1.0.0';

  @override
  String get companyName => 'RAHOCLUB';

  @override
  String get companyClubName => 'RAHO 俱乐部';

  @override
  String get companyTagline => '逆龄与稳态俱乐部';

  @override
  String get supportedBy => '支持方：';

  @override
  String get success => '成功';

  @override
  String get error => '错误';

  @override
  String get warning => '警告';

  @override
  String get info => '信息';

  @override
  String get onboardingTitle1 => '纳米气泡技术';

  @override
  String get onboardingSubtitle1 => '全球首个使用纳米气泡技术作为医疗设备的保健服务';

  @override
  String get onboardingTitle2 => '健康专家';

  @override
  String get onboardingSubtitle2 => '由健康领域专业医生支持';

  @override
  String get onboardingTitle3 => '会员服务';

  @override
  String get onboardingSubtitle3 => '由优质医疗团队为您服务，优先考虑您的福祉';

  @override
  String get buttonSkipOnboarding => '跳过';

  @override
  String get buttonCompleteOnboarding => '完成';

  @override
  String get buttonNextOnboarding => '下一步';

  @override
  String get buttonPreviousOnboarding => '上一步';

  @override
  String get forgotPasswordButton => '忘记密码？';

  @override
  String get passwordEmptyError => '密码不能为空';

  @override
  String get passwordMinLengthError => '密码至少8个字符';

  @override
  String get confirmPasswordLabel => '确认密码';

  @override
  String get confirmPasswordHintText => '重新输入密码';

  @override
  String get confirmPasswordEmptyError => '确认密码不能为空';

  @override
  String get passwordMismatchError => '密码不匹配';

  @override
  String get processingText => '处理中...';

  @override
  String get verificationTitle => '会员验证';

  @override
  String get verificationSubtitle => '输入您的会员注册ID进行验证';

  @override
  String get idRegisterHintText => '输入注册ID';

  @override
  String get idRegisterLabel => '注册ID';

  @override
  String get verificationButton => '发送验证码';

  @override
  String get otpTitle => '验证码';

  @override
  String otpSubtitle(String number_phone) {
    return '输入发送到 $number_phone 的验证码';
  }

  @override
  String get otpNotReceive => '没收到验证码？';

  @override
  String get otpResend => '重新发送';

  @override
  String get otpButton => '验证';

  @override
  String get verifiedNumberTitle => '验证成功';

  @override
  String get verifiedNumberSubtitle => '恭喜！您已在我们的系统中成功验证为会员';

  @override
  String get createPassword => '创建密码';

  @override
  String get createPasswordSupportText => '创建您的认证密码';

  @override
  String get createPasswordHintText => '新密码';

  @override
  String get passwordButton => '创建并登录';

  @override
  String get loginTitle => '欢迎';

  @override
  String get loginSubtitle => '请登录您的账户';

  @override
  String get passwordLabel => '密码';

  @override
  String get passwordHintText => '输入密码';

  @override
  String get loginButton => '登录';

  @override
  String get loginErrorRequiredField => '注册ID和密码为必填项';

  @override
  String get loginAuthenticationFailed => '注册ID或密码无效';

  @override
  String get loginSuccess => '登录成功';

  @override
  String get dashboardBottomNavText => '首页';

  @override
  String get therapyBottomNavText => '治疗';

  @override
  String get transactionBottomNavText => '交易';

  @override
  String get profileBottomNavText => '个人资料';

  @override
  String get profilePageTitle => '我的资料';

  @override
  String get themeDarkLabel => '深色';

  @override
  String get themeLightLabel => '浅色';

  @override
  String get personalSectionTitle => '个人';

  @override
  String get supportSectionTitle => '支持';

  @override
  String get settingsSectionTitle => '设置';

  @override
  String get personalDataMenuTitle => '个人资料';

  @override
  String get personalDataMenuSubtitle => '管理您的个人信息';

  @override
  String get diagnosisMenuTitle => '我的诊断';

  @override
  String get diagnosisMenuSubtitle => '医疗诊断历史';

  @override
  String get referenceCodeMenuTitle => '参考代码';

  @override
  String get referenceCodeMenuSubtitle => '服务参考代码';

  @override
  String get branchLocationMenuTitle => '分店位置';

  @override
  String get branchLocationMenuSubtitle => '查找最近分店';

  @override
  String get helpMenuTitle => '帮助';

  @override
  String get helpMenuSubtitle => '帮助中心与支持';

  @override
  String get languageMenuTitle => '语言';

  @override
  String get languageMenuSubtitle => '更改应用语言';

  @override
  String get aboutAppMenuTitle => '关于应用';

  @override
  String get aboutAppMenuSubtitle => '详细应用信息';

  @override
  String get logoutButtonLabel => '登出';

  @override
  String get personalInfoSectionTitle => '个人信息';

  @override
  String get fieldLabelNIK => '身份证号';

  @override
  String get fieldLabelAddress => '地址';

  @override
  String get fieldLabelCity => '城市/地区';

  @override
  String get fieldLabelDateOfBirth => '出生日期';

  @override
  String get fieldLabelAge => '年龄';

  @override
  String get fieldSuffixYears => '岁';

  @override
  String get fieldLabelGender => '性别';

  @override
  String get fieldLabelPhone => 'WhatsApp号码';

  @override
  String get referenceInfoTitle => '参考信息';

  @override
  String get cardNumberFieldLabel => '卡号';

  @override
  String get referralNameFieldLabel => '推荐人姓名';

  @override
  String get diagnosisNoteTitle => '附加说明';

  @override
  String get diagnosisCurrentIllnessTitle => '当前症状和病史';

  @override
  String get diagnosisPreviousIllnessTitle => '既往病史和家族史';

  @override
  String get diagnosisSocialHabitTitle => '社会和生活习惯史';

  @override
  String get diagnosisTreatmentHistoryTitle => '治疗史';

  @override
  String get diagnosisPhysicalExamTitle => '体格检查';

  @override
  String get aboutDialogTitle => '关于应用';

  @override
  String get aboutVersionLabel => '版本';

  @override
  String get aboutCopyrightLabel => '版权';

  @override
  String get aboutReleaseDateLabel => '发布日期';

  @override
  String get aboutCloseButton => '关闭';

  @override
  String get languageDialogTitle => '选择语言';

  @override
  String get languageOptionIndonesian => '印尼语';

  @override
  String get languageOptionEnglish => '英语';

  @override
  String get languageOptionChinese => '中文';

  @override
  String get languageCancelButton => '取消';

  @override
  String get languageSaveButton => '保存';

  @override
  String get logoutDialogTitle => '确认登出';

  @override
  String get logoutDialogMessage => '您确定要登出吗？';

  @override
  String get logoutCancelButton => '取消';

  @override
  String get logoutConfirmButton => '登出';

  @override
  String get dashboardWelcome => '欢迎';

  @override
  String get dashboardYourVoucher => '您的优惠券';

  @override
  String get dashboardUsedVoucher => '已使用优惠券';

  @override
  String get dashboardLastTherapy => '最近治疗';

  @override
  String get dashboardEventPromo => '活动与促销';

  @override
  String dashboardTherapyInfusionNumber(String infusion_number) {
    return '第$infusion_number次输液';
  }

  @override
  String get myVoucherTitle => '我的优惠券';

  @override
  String get voucherFilterDate => '选择日期';

  @override
  String get voucherDateAll => '所有日期';

  @override
  String get voucherDateToday => '今天';

  @override
  String get voucherDate7Days => '最近7天';

  @override
  String get voucherDate30Days => '最近30天';

  @override
  String get voucherDate60Days => '最近60天';

  @override
  String get voucherDate90Days => '最近90天';

  @override
  String voucherRedeemDate(String redeem_date) {
    return '兑换于 $redeem_date';
  }

  @override
  String voucherRedeemDateLabel(String redeem_date) {
    return '兑换日期：$redeem_date';
  }

  @override
  String get transactionDetailTitle => '交易详情';

  @override
  String get transactionStatusPaid => '已支付';

  @override
  String get transactionTherapyDone => '治疗服务已完成';

  @override
  String transactionAmount(String amount) {
    return '¥$amount';
  }

  @override
  String get transactionDetailMemberName => '会员姓名';

  @override
  String get transactionDetailInvoiceNumber => '发票号';

  @override
  String get transactionDetailBranchClinic => '分店诊所';

  @override
  String get transactionDetailDate => '日期';

  @override
  String get transactionDetailTherapyType => '治疗类型';

  @override
  String get transactionDetailPaymentMethod => '支付方式';

  @override
  String get transactionDetailVoucherQty => '优惠券数量';

  @override
  String get transactionDetailFreeVoucher => '免费优惠券';

  @override
  String get transactionDetailUnitPrice => '单价';

  @override
  String get transactionDetailTotalAmount => '总金额';

  @override
  String get transactionActionDownload => '下载';

  @override
  String get transactionActionShare => '分享';

  @override
  String get transactionActionSeeRedeemVoucher => '查看已兑换优惠券';

  @override
  String get therapyDetailTitle => '治疗详情';

  @override
  String get therapyInfoMember => '会员';

  @override
  String get therapyInfoDate => '日期';

  @override
  String get therapyStartSurvey => '开始调查';

  @override
  String get therapyTabHistory => '治疗历史';

  @override
  String get therapyTabSurvey => '调查历史';

  @override
  String get therapySurveyEmpty => '暂无调查数据';

  @override
  String get therapyInfoCardTitle => '治疗信息';

  @override
  String get therapyInfusNumber => '输液次数';

  @override
  String get therapyInfusType => '输液类型';

  @override
  String get therapyProductionDate => '生产日期';

  @override
  String get therapyNextInfusDate => '下次输液';

  @override
  String get therapyHealingCrisisTitle => '康复危机';

  @override
  String get therapyHealingCrisisComplaint => '康复危机症状';

  @override
  String get therapyHealingCrisisNote => '备注/措施';

  @override
  String get therapyNeedleUsageTitle => '针具使用';

  @override
  String get therapyNeedleUsageHeaderNeedle => '针具';

  @override
  String get therapyNeedleUsageHeaderNakes => '医护人员';

  @override
  String get therapyNeedleUsageHeaderStatus => '状态';

  @override
  String get therapyNeedleUsed => '已使用';

  @override
  String get therapySectionAnamnesis => '病史询问';

  @override
  String get therapySectionLabPhoto => '化验照片';

  @override
  String get therapyLabPhotoEmpty => '暂无化验照片';

  @override
  String get therapyComplaintAfter => '治疗后症状';

  @override
  String get therapyComplaintBefore => '治疗前症状';

  @override
  String get therapyNoComplaint => '无症状';

  @override
  String get therapyVitalSignBloodPressure => '血压';

  @override
  String get therapyVitalSignSystolic => '收缩压';

  @override
  String get therapyVitalSignDiastolic => '舒张压';

  @override
  String get therapyVitalSignO2AndHR => '血氧饱和度与心率';

  @override
  String get therapyVitalSaturationBefore => '治疗前饱和度';

  @override
  String get therapyVitalSaturationAfter => '治疗后饱和度';

  @override
  String get therapyVitalPerfusionBefore => '治疗前灌注指数';

  @override
  String get therapyVitalPerfusionAfter => '治疗后灌注指数';

  @override
  String get therapyVitalHRBefore => '治疗前心率';

  @override
  String get therapyVitalHRAfter => '治疗后心率';

  @override
  String get historyPageTitle => '我的历史';

  @override
  String get therapyTabTherapy => '治疗';

  @override
  String get therapyTabLab => '化验';

  @override
  String get therapySearchHint => '搜索治疗历史...';

  @override
  String get labSearchHint => '搜索化验历史...';

  @override
  String therapyCardInfusionNumber(String infusionNumber) {
    return '第$infusionNumber次输液';
  }

  @override
  String get therapyEmptyTitle => '暂无治疗历史';

  @override
  String get therapyEmptySubtitle => '您的治疗历史将显示在这里';

  @override
  String get labEmptyTitle => '暂无化验数据';

  @override
  String get labEmptySubtitle => '添加或加载化验数据后，数据将显示在这里';

  @override
  String get filterTitle => '筛选';

  @override
  String get filterClear => '清除';

  @override
  String get filterCompany => '公司';

  @override
  String get filterProduct => '产品';

  @override
  String get filterDateRange => '日期范围';

  @override
  String get selectCompany => '选择公司';

  @override
  String get selectProduct => '选择产品';

  @override
  String get dateFrom => '起始日期';

  @override
  String get dateTo => '结束日期';

  @override
  String get applyFilter => '应用筛选';

  @override
  String get retry => '重试';

  @override
  String get noTransactionsFound => '未找到交易';

  @override
  String get noDataAvailable => '暂无数据';

  @override
  String get transactionStatusPending => '待处理';

  @override
  String get transactionStatusCancelled => '已取消';

  @override
  String get transactionDetailAdmin => '管理员';

  @override
  String get transactionDetailPaymentStatus => '支付状态';

  @override
  String get therapyLoadingError => '加载治疗历史失败';

  @override
  String get genericError => '发生错误，请稍后重试';

  @override
  String languageChangeSuccess(String language) {
    return '语言已更改为$language';
  }

  @override
  String get branchLocationTitle => 'Rahoclub分店';

  @override
  String get branchLocationRetry => '重试';

  @override
  String get branchLocationLoading => '正在加载分店数据...';

  @override
  String get branchLocationEmpty => '暂无分店数据';

  @override
  String get branchLocationEmptyHint => '请稍后重试';

  @override
  String get branchLocationReload => '尝试重新加载';

  @override
  String get diagnosisReload => '尝试重新加载';

  @override
  String get diagnosisEmpty => '暂无诊断数据';

  @override
  String get diagnosisReloadButton => '重新加载';

  @override
  String get genderMale => '男';

  @override
  String get genderFemale => '女';

  @override
  String get genderSelectLabel => '选择性别';

  @override
  String get genderSelectTitle => '选择性别';

  @override
  String get personalDataCancelButton => '取消';

  @override
  String get personalDataSaveButton => '保存';

  @override
  String get personalDataEditButton => '编辑';

  @override
  String referenceErrorMessage(String message) {
    return '错误：$message';
  }

  @override
  String get referenceNoData => '暂无数据';

  @override
  String get companyLoadError => '加载分店数据失败';

  @override
  String languageLoadError(String error) {
    return '加载语言失败：$error';
  }

  @override
  String get languageUnsupported => '不支持该语言';

  @override
  String languageChangeError(String error) {
    return '更改语言失败：$error';
  }

  @override
  String languageResetError(String error) {
    return '重置语言失败：$error';
  }

  @override
  String get profileLoadError => '加载个人资料失败';

  @override
  String get diagnosisLoadError => '加载诊断失败';

  @override
  String get profileUpdateSuccess => '个人资料更新成功';

  @override
  String get profileUpdateError => '更新个人资料失败';

  @override
  String get needleDataEmpty => '暂无数据';

  @override
  String get labTestTitle => '化验检查';

  @override
  String get labResultLabel => '化验结果';

  @override
  String get errorStateTitle => '发生错误';

  @override
  String get errorStateRetry => '重试';

  @override
  String get labLoadError => '加载数据失败';

  @override
  String get labLoadMoreError => '加载更多数据失败';

  @override
  String get therapyLoadError => '加载数据失败';

  @override
  String get therapyLoadMoreError => '加载更多数据失败';

  @override
  String get transactionLoadError => '加载交易失败';

  @override
  String get transactionDetailNotFound => '未找到交易详情';

  @override
  String get transactionIdRequired => '需要交易ID';

  @override
  String get transactionTypeInvalid => '无效交易类型，必须是\'payment\'或\'faktur\'';

  @override
  String get transactionNotFound => '未找到交易';

  @override
  String get transactionDetailLoadError => '加载交易详情失败';

  @override
  String get transactionFilterLabel => '选择交易';

  @override
  String get transactionFilterAll => '所有交易';

  @override
  String get transactionFilterPayment => '购买';

  @override
  String get transactionFilterService => '服务';

  @override
  String get transactionPaymentDefault => '支付';

  @override
  String get transactionServiceDefault => '治疗';

  @override
  String get transactionNoPaymentFound => '未找到购买交易';

  @override
  String get transactionNoServiceFound => '未找到服务交易';

  @override
  String transactionErrorMessage(String message) {
    return '错误：$message';
  }

  @override
  String get authSessionRestored => '会话恢复成功';

  @override
  String get authProfileUpdated => '个人资料更新成功';

  @override
  String authRefreshError(String error) {
    return '更新个人资料失败：$error';
  }

  @override
  String authLogoutError(String error) {
    return '登出失败：$error';
  }

  @override
  String get error_server => '服务器错误';

  @override
  String get require_id => '注册ID为必填项';

  @override
  String get id_not_found => '未找到注册ID';

  @override
  String get otp_failed => '发送验证码失败';

  @override
  String get otp_max_attempt => '已达到验证码最大尝试次数';

  @override
  String get otp_invalid => '验证码无效';

  @override
  String get otp_expired => '验证码已过期';

  @override
  String get otp_max_daily => '已达到每日验证码请求限制';

  @override
  String get otp_sended => '验证码已发送到您的WhatsApp';

  @override
  String get otp_verified => '验证码验证成功';

  @override
  String get already_verified => '号码已验证';

  @override
  String get unknown_error => '未知错误';

  @override
  String get companies_empty => '暂无公司分店数据';

  @override
  String get companies_fetch_success => '公司分店数据获取成功';

  @override
  String get dashboard_fetch_success => '仪表板数据加载成功';

  @override
  String get profile_fetch_success => '个人资料数据获取成功';

  @override
  String get diagnosis_fetch_success => '诊断数据获取成功';

  @override
  String get references_fetch_success => '参考数据获取成功';

  @override
  String get profile_update_success => '个人资料更新成功';

  @override
  String get invalid_field_type => '字段格式无效';

  @override
  String get invalid_sex_value => '性别字段值无效';

  @override
  String get invalid_date_format => '日期格式无效（请使用DD-MM-YYYY）';

  @override
  String get invalid_image_format => '图片格式无效或已损坏';

  @override
  String get patient_not_found => '未找到患者';

  @override
  String get transaction_fetch_success => '交易数据获取成功';

  @override
  String get transaction_detail_fetch_success => '交易详情获取成功';

  @override
  String get invalid_transaction_type => '无效交易类型';

  @override
  String get transaction_not_found => '未找到交易';

  @override
  String get transaction_id_required => '交易ID为必填项';

  @override
  String get therapy_history_success => '治疗历史数据获取成功';

  @override
  String get therapy_history_failed => '获取治疗历史数据失败';

  @override
  String get lab_data_fetched => '化验数据获取成功';

  @override
  String get error_system => '系统错误';

  @override
  String get therapy_not_found => '未找到治疗数据或访问被拒绝';

  @override
  String get therapy_detail_success => '治疗详情获取成功';

  @override
  String get therapy_detail_failed => '获取治疗详情失败';

  @override
  String get lab_id_required => '化验ID为必填项';

  @override
  String get lab_record_not_found => '未找到化验数据';

  @override
  String get lab_detail_fetched => '化验详情获取成功';
}
