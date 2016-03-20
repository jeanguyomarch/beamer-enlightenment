Enlightenment Beamer Theme (beamerenlightenment)
================================================

This is an **unofficial** Enlightenment beamer theme.

Pre-requisites
--------------

- `make`;
- `latexmk`;
- a LaTeX distribution (e.g. texlive).


Usage
-----

The following targets are offered:
- `all` (default target): compiles the slides as PDF;
- `pdf`: generates the slides as PDF (same than 'all');
- `clean`: remove all generated files;
- `install`: install the beamer theme at the prefix specified by the `PREFIX`
  environment variable (default is `$HOME`: the package will be installed in
  `$PREFIX/texmf`);
- `package` generates the ZIP file containing the
  [TDS](http://distrib-coffee.ipsl.jussieu.fr/pub/mirrors/ctan/tds/tds.pdf).


Example:

```bash
make install   # Will install the package in ~/texmf
sudo make PREFIX=/usr/local/share install # Will install the package in /usr/local/share/texmf
```

Use this enlightenment theme in your Beamer presentation:

```latex
\documentclass{beamer}
\usetheme{enlightenment}

\begin{document}
% ...
\end{document}

```

Please refer to `demo.tex` for a real usecase. Run `make` to compile the
beamer slides of the demo with the enlightenment theme.


License
=======

This Beamer Theme is released under the MIT License.
See the `LICENSE.md` file for more details.

For more details about the Enlightenment Logo please refer to
https://www.enlightenment.org/.
