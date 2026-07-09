/// Бэкенд отдаёт описания в HTML (`<p>...</p>`, `<strong>` и т.п.), а сайт
/// рендерит его как разметку. У нас в приложении простой Text/RichText без
/// HTML-рендера, поэтому теги убираем — но сперва блочные (`</p>`, `<br>`,
/// `</div>`) превращаем в перенос строки, иначе абзацы склеиваются в одно
/// предложение без пробела между ними.
String stripHtml(String? html) {
  if (html == null || html.isEmpty) return '';
  return html
      .replaceAll(RegExp(r'<br\s*/?>', caseSensitive: false), '\n')
      .replaceAll(RegExp(r'</\s*(p|div)\s*>', caseSensitive: false), '\n\n')
      .replaceAll(RegExp(r'<[^>]*>'), '')
      .replaceAll('&nbsp;', ' ')
      .replaceAll('&amp;', '&')
      .replaceAll('&lt;', '<')
      .replaceAll('&gt;', '>')
      .replaceAll('&quot;', '"')
      .replaceAll('&#39;', "'")
      .replaceAll(RegExp(r'\n{3,}'), '\n\n')
      .trim();
}
