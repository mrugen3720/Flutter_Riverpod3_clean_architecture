enum DateTimeFormatter {
  dd_MM_yyyy('dd-MM-yyyy'),
  yyyy_MM_dd('yyyy-MM-dd'),
  MMM_yy('MMM yy'),
  MMMM_yy('MMMM yyyy'),
  dd_MMM_yyyy('dd MMM yyyy'),
  dd_MMM_quote_yy("dd MMM 'yy"),
  dd_MMM_quote_yy_HH_MM_a("dd MMM 'yy HH:mm a"),
  MMM_dd_yyyy('MMM dd, yyyy'),
  MMM_dd_yyyy_HH_mm_a('MMM dd, yyyy HH:mm a'),
  d_MMM_yyyy('d MMM yyyy'),
  d_MMM_yyyy_EEEE('d MMM yyyy, EEEE'),
  dd_MMM('dd MMM'),
  MMMM_d_suffix_yyyy('MMMM d_suffix yyyy'),
  d_suffix_MMM_yyyy('d_suffix MMM yyyy'),
  d_suffix_MMMM_yyyy('d_suffix MMMM yyyy'),
  EEEE('EEEE'),
  d_suffix('d_suffix'),
  yyyy_MM_dd_T_HH_MM_SS_SSSSSS_Z("yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'"),
  yyyy_MM_dd_HH_MM_SS_SSS_Z("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"),
  yyyy_MM_dd_T_HH_mm_ss_Z("yyyy-MM-dd'T'HH:mm:ss'Z'"),
  yyyy_MM_dd_T_HH_mm_sss_Z("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"),
  yyyy_MM_dd_HH_mm_ss('yyyy-MM-dd HH:mm:ss'),
  yyyy_mm_dd_HH_mm('yyyy-mm-dd HH:mm'),
  HH('HH'),
  HH_MM('HH:mm'),
  HH_MM_SS('HH:mm:ss'),
  HH_MM_a('HH:mm a'),
  hh_mm_a('hh:mm a'),
  EEE_MMM_dd_HH_mm_ss_zzz_yyyy('EEE MMM dd HH:mm:ss zzz yyyy'),
  yyyymmddthhmmssz("yyyyMMdd'T'HHmmss'Z'"),
  yyyymmdd('yyyyMMdd'),
  dd_MM_yyyy_with_slash('dd/MM/yyyy'),
  dd_MM_yy('dd/MM/yy');

  final String pattern;

  const DateTimeFormatter(this.pattern);
}
