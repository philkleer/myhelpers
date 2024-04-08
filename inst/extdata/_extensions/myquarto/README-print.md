# Guide on how to print the Quarto Presentation to PDF
With this builded slide, it is automatically created a copy of the necessary `puppeteer cache-folder` (`.cache/puppeteer/chrome/...`) of the specific chrome version decktape needs. With this you can run the `decktape`-command to convert your pdf 


1. Install Decktape

1. Regard that scroll slides & tabs have no support in PDFs! 

1. Copy the files from `/Users/phil/.cache/puppeteer/` into `./.cache/`

1. Go in the terminal, where your generated `html`-file lies and run one of the following commands:

  1. With fragments: `decktape ipsa.html?fragments=true ipsa.pdf --screen-shot=1280x720 --pdf-author 'Dr. Philipp Kleer' --pdf-title 'IPSA'`
  
  1. Without fragments: `decktape ipsa.html ipsa.pdf --screen-shot=1280x720 --pdf-author 'Dr. Philipp Kleer' --pdf-title 'IPSA'`
