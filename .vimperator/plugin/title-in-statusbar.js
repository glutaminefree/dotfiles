var INFO = xml`
<plugin name="title-in-statusbar" version="0.01"
        href="http://ororo.ru"
        summary="Show page title on statusbar."
        lang="en_US"
        xmlns="http://vimperator.org/namespaces/liberator">
  <author email="glutaminefree@mail.ru">glutaminefree</author>
  <project name="Vimperator" minVersion="3.10.1"/>
  <license>MIT style license</license>
  <p>Show page title on statusbar.</p>
</plugin>`;

commands.addUserCommand(['showtitle', 'st'], 'Show page title', function(args){
	let doc = config.browser.contentWindow.document;
	let title = '[' + doc.title + ']' || "[No Title]";
	liberator.echo(title);
});
