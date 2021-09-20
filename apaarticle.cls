%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ArticuloAPA                                                                  %
% Class File                                                                   %
% Version 1.5 (17/july/2021)                                                   %
%                                                                              %
% Authors:                                                                     %
% Rodolfo Arturo González Trillo                                               %
%                                                                              %
% Class license:                                                               %
% LPPL v1.3c (http://www.latex-project.org/lppl)                               %
%                                                                              %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%------------------------------------------------------------------------------%
%                       CLASS DEFINITION AND PARAMETERS                        %
%------------------------------------------------------------------------------%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{articuloAPA}[2021/07/14 My custom article class whith APA]

% Load article
\providecommand{\baseclass}{article}
\LoadClass{\baseclass}

%------------------------------------------------------------------------------%
%                       CUSTOM NAME COMMANDS & METADATA                        %
%------------------------------------------------------------------------------%
\RequirePackage[bookmarks, colorlinks]{hyperref}

\DeclareDocumentCommand{\author}{m}{%
  \newcommand{\atauthor}{#1}
  \renewcommand{\@author}{#1}
  \hypersetup{pdfauthor={#1}}
}%
 
\DeclareDocumentCommand{\title}{m}{%
  \hypersetup{pdftitle={#1}}
  \newcommand{\attitle}{#1}
  \renewcommand{\@title}{#1}
}%

\DeclareDocumentCommand{\date}{m}{%
  \newcommand{\atdate}{#1}
  \renewcommand{\@date}{#1}
}%


\NewDocumentCommand{\course}{m}{%
  \hypersetup{pdfsubject={#1}}
  \newcommand{\atcourse}{#1}
}%

\NewDocumentCommand{\activity}{m}{\newcommand{\atactivity}{#1}}
\NewDocumentCommand{\keywords}{m}{%
  \hypersetup{pdfkeywords={#1}}
  \newcommand{\atkeywords}{#1}
}%
\NewDocumentCommand{\assignment}{m}{\newcommand{\atassignment}{#1}}

    
%------------------------------------------------------------------------------%
%                                    FONTS                                     %
%------------------------------------------------------------------------------%
 
\RequirePackage{fontspec}
\RequirePackage[spanish,es-nodecimaldot]{babel}
\RequirePackage{amsmath}
\RequirePackage{unicode-math}
\RequirePackage[sfdefault]{carlito}

\defaultfontfeatures{Scale=MatchUppercase}
\setmonofont{Consolas}
\setmathfont{FiraMath-Regular.otf}
\setmathfont[range={up,"002B,"002D,`±,`×,`·,`÷,`¬,`∂,`∆,`∕,`∞,`⌐}]{Carlito}
\setmathfont[range={\nabla}]{XITSMath-Regular.otf}
\setmathfont[range=it]{Carlito Italic}
\setmathfont[range=bfup]{Carlito Bold}
\setmathfont[range=bfit]{Carlito Bold Italic}
\RequirePackage[babel]{csquotes}

\setoperatorfont\normalfont % For log, sin, cos, etc.


%------------------------------------------------------------------------------%
%                           LINE SPACING & MARGINS                             %
%------------------------------------------------------------------------------%
\RequirePackage{setspace}

% Spacing
\onehalfspacing

\RequirePackage[left=1.3cm,right=1.3cm,top=2.3 cm,bottom=2.0cm]{geometry}

% Column separation.
\setlength{\columnsep}{0.5cm}

% To impede overfull hboxes
\setlength{\emergencystretch}{10pt}
%------------------------------------------------------------------------------%
%                                    COLORS                                    %
%------------------------------------------------------------------------------%
\RequirePackage[table]{xcolor}
\definecolor{aqua}{RGB}{0,152,205}
\definecolor{aqua1}{RGB}{133,223,255}
\definecolor{aqua2}{RGB}{194,239,255}
\definecolor{aqua3}{RGB}{230,244,249}

\definecolor{mydarkgreen}{RGB}{135,172,66}
\definecolor{mygreen}{RGB}{169,215,83}

\definecolor{mydarkyellow}{RGB}{194,154,52}
\definecolor{myyellow}{RGB}{242,193,65}

\definecolor{mydarkorange}{RGB}{196,126,34}
\definecolor{myorange}{RGB}{245,158,42}

\definecolor{mydarkred}{RGB}{190,50,54}
\definecolor{myred}{RGB}{238,63,68}

\definecolor{mydarkhibuscus}{RGB}{157,52,86}
\definecolor{myhibiscus}{RGB}{196,65,107}



%------------------------------------------------------------------------------%
%                                    LINKS                                     %
%------------------------------------------------------------------------------%
%\RequirePackage[bookmarks, colorlinks]{hyperref}
\hypersetup{%
  pdfpagemode={UseOutlines},
  bookmarksopen=true,
  bookmarksopenlevel=0,
  hypertexnames=false,
  colorlinks=true,% Set to false to disable coloring links
  citecolor=aqua,% The color of citations
  linkcolor=aqua,% The color of references to document elements (sections, figures, etc)
  urlcolor=aqua,% The color of hyperlinks (URLs)
  pdfstartview={FitV},
  unicode,
  breaklinks=true,
}%

\RequirePackage[all]{hypcap} %Hiperref te lleva a la parte superior de la imagen.

%------------------------------------------------------------------------------%
%                                  BIBLATEX                                    %
%------------------------------------------------------------------------------%
% Use the bibtex backend with the authoryear citation style (which resembles APA)
\RequirePackage[%
  style=apa,
  backend=biber,
  isbn=true,
  url=true,
  doi=true,
  natbib=true
  ]{biblatex}%
\addbibresource{biblography.bib}

\DeclareDelimFormat*{finalnamedelim}
  {\ifnum\value{liststop}>2 \finalandcomma\fi\addspace{y}\space}

% the bibliography also needs another conditional, so we can't wrap
% everything up with just the two lines above
\DeclareDelimFormat[bib,biblist]{finalnamedelim}{%
  \ifthenelse{\value{listcount}>\maxprtauth}
    {}
    {\ifthenelse{\value{liststop}>2}
       {\finalandcomma\addspace\bibstring{and}\space}
       {\addspace{y}\space}}}

% this is a special delimiter to solve the bugs reported in
% https://tex.stackexchange.com/q/417648/35864
\DeclareDelimFormat*{finalnamedelim:apa:family-given}{%
  \ifthenelse{\value{listcount}>\maxprtauth}
    {}
    {\finalandcomma\addspace{y}\space}}


%------------------------------------------------------------------------------%
%                      WHOLE COLOR LINKING CITE COMMANDS                       %
%------------------------------------------------------------------------------%
\makeatletter
\newcommand*{\linkblx@startlink}[1]{%
  \blx@sfsave\hyper@natlinkstart{\the\c@refsection @#1}\blx@sfrest}
\newcommand*{\linkblx@startlinkentry}{%
  \linkblx@startlink{\abx@field@entrykey}}
\newcommand*{\linkblx@endlink}{%
  \blx@sfsave\hyper@natlinkend\blx@sfrest}

\DeclareCiteCommand{\cite}
  {}%
  {\DeclareFieldFormat{bibhyperref}{####1}%
   \linkblx@startlinkentry
   \ifnumequal{\value{citecount}}{1}
     {\usebibmacro{prenote}}
     {}%
   \usebibmacro{citeindex}%
   \usebibmacro{cite}%
   \ifnumequal{\value{citecount}}{\value{citetotal}}
     {\usebibmacro{postnote}}
     {}%
   \iflastcitekey{}{\multicitedelim}%
   \linkblx@endlink}
  {}
  {}

\DeclareCiteCommand*{\cite}
  {}%
  {\DeclareFieldFormat{bibhyperref}{####1}%
   \linkblx@startlinkentry
   \ifnumequal{\value{citecount}}{1}
     {\usebibmacro{prenote}}
     {}%
   \usebibmacro{citeindex}%
   \usebibmacro{citeyear}%
   \ifnumequal{\value{citecount}}{\value{citetotal}}
     {\usebibmacro{postnote}}
     {}%
   \iflastcitekey{}{\multicitedelim}%
   \linkblx@endlink}
  {}
  {}

\DeclareCiteCommand{\parencite}
  {}%
  {\DeclareFieldFormat{bibhyperref}{####1}%
   \linkblx@startlinkentry
   \iffirstcitekey{\bibopenparen}{}%
   \ifnumequal{\value{citecount}}{1}
     {\usebibmacro{prenote}}
     {}%
   \usebibmacro{citeindex}%
   \usebibmacro{cite}%
   \ifnumequal{\value{citecount}}{\value{citetotal}}
     {\usebibmacro{postnote}}
     {}%
   \iflastcitekey{\bibcloseparen}{\multicitedelim}%
   \linkblx@endlink}
  {}
  {}

\DeclareCiteCommand*{\parencite}
  {}%
  {\DeclareFieldFormat{bibhyperref}{####1}%
   \linkblx@startlinkentry
   \iffirstcitekey{\bibopenparen}{}%
   \ifnumequal{\value{citecount}}{1}
     {\usebibmacro{prenote}}
     {}%
   \usebibmacro{citeindex}%
   \usebibmacro{citeyear}%
   \ifnumequal{\value{citecount}}{\value{citetotal}}
     {\usebibmacro{postnote}}
     {}%
   \iflastcitekey{\bibcloseparen}{\multicitedelim}%
   \linkblx@endlink}
  {}
  {}


\DeclareCiteCommand{\textcite}
  {\boolfalse{cbx:parens}}
  {\DeclareFieldFormat{bibhyperref}{####1}%
   \linkblx@startlinkentry
   \usebibmacro{citeindex}%
   \iffirstcitekey
     {\setcounter{textcitetotal}{1}}
     {\stepcounter{textcitetotal}%
      \textcitedelim}%
   \usebibmacro{textcite}%
   \iflastcitekey
     {}
     {\ifbool{cbx:parens}
        {\bibcloseparen\global\boolfalse{cbx:parens}}
        {}}%
   \ifnumequal{\value{citecount}}{\value{citetotal}}
     {\usebibmacro{textcite:postnote}}
     {}%
   \linkblx@endlink}
  {}
  {}

\DeclareMultiCiteCommand{\parencites}{\parencite}{}
\makeatother

\newcommand{\Figura}[1]{\hyperref[#1]{Figura \ref*{#1}}}
\newcommand{\Tabla}[1]{\hyperref[#1]{Tabla \ref*{#1}}}
\newcommand{\Seccion}[1]{\hyperref[#1]{Sección \ref*{#1}}}
\newcommand{\figura}[1]{\hyperref[#1]{figura \ref*{#1}}}
\newcommand{\tabla}[1]{\hyperref[#1]{tabla \ref*{#1}}}
\newcommand{\seccion}[1]{\hyperref[#1]{sección \ref*{#1}}}
\newcommand{\codigo}[1]{\hyperref[#1]{código \ref*{#1}}}
\newcommand{\salida}[2]{\hyperref[#1]{salida \ref*{#2}}}


%------------------------------------------------------------------------------%
%                                   FIGURES                                    %
%------------------------------------------------------------------------------%
\RequirePackage{graphicx}
\RequirePackage{hypcap}
\RequirePackage{booktabs,caption}
\RequirePackage{subcaption}
\RequirePackage{placeins} % Para que no pasen las tablas.

% Specifies where to look for included images.
\graphicspath{{figures/}{./}{../figures/}}

% Sources bellow captions.
\newcommand{\source}[1]{\vspace{-8pt} \caption*{ \textbf{Fuente:} {#1}} }
\captionsetup{justification=centerlast, font=small, labelfont=bf}

% New command for a rule to be used under captions.
\newcommand{\decoRule}[1]{\rule{#1}{.4pt}} 

%------------------------------------------------------------------------------%
%                                  TABLES                                      %
%------------------------------------------------------------------------------%
\RequirePackage{tabulary}
\RequirePackage[flushleft]{threeparttable}
% Cambio de nombre:
\addto\captionsspanish{
\def\listtablename{\'Indice de tablas}%
\def\tablename{Tabla}}

\newlength\tablelength
\setlength\tablelength{0.4\textwidth}

\newcommand{\centered}[1]{\begin{tabular}{l} #1 \end{tabular}}
%------------------------------------------------------------------------------%
%                             HEADERS AND FOOTERS                              %
%------------------------------------------------------------------------------%
\RequirePackage{fancyhdr}
\RequirePackage{multirow}
\pagestyle{fancy}
\fancyhf{}
\chead{\footnotesize \atactivity}
\rfoot{\thepage}
\renewcommand{\headrulewidth}{0.4pt}
\renewcommand{\footrulewidth}{0.4pt}

\fancypagestyle{noheader}{
   \fancyhead{}
   \renewcommand{\headrule}{\hrule height 0pt \vspace{0mm}\hrule height 0pt}
}

%------------------------------------------------------------------------------%
%                                 TITLE PAGE                                   %
%------------------------------------------------------------------------------%
\renewcommand{\maketitle}{
  \thispagestyle{noheader}
  \noindent
  \begin{center}
  	 \vspace*{-48pt}
     \includegraphics[height=0.058\paperheight]{logo.png}\\ 
     \rule{\textwidth}{4pt}\\ 
     \hspace{3pt} Nombre: \textbf{\atauthor} \hfill Actividad: \textbf{\atassignment} \hspace*{3pt} \\
     [5pt]
    \hspace{3pt} Asignatura: \textbf{\atcourse} \hfill Fecha: \textbf{\atdate} \hspace*{3pt}\\ 
     \rule{\textwidth}{2pt}\vspace{7pt} \\
     
   \huge \textbf{\attitle}
   \end{center}
}
%------------------------------------------------------------------------------%
%                      SECTION WITHOUT NUMBERS ARE INDEXED                     %
%------------------------------------------------------------------------------%
\newcommand{\indexed}[2]{%
	\addcontentsline{toc}{#1}{#2}
	\expandafter\csname#1\endcsname*{#2}
}


%------------------------------------------------------------------------------%
%                                  LIST STYLE                                  %
%------------------------------------------------------------------------------%
\renewcommand{\labelitemi}{$\textcolor{aqua}{\bullet}$}

%------------------------------------------------------------------------------%
%                                  CODE BOXES                                  %
%------------------------------------------------------------------------------%
\RequirePackage{tcolorbox}
\tcbuselibrary{minted, most}

% the space reserved between for the ``In'' numbers and the code
\newlength\inwd
\setlength\inwd{0.75cm}
\newcounter{ipythcntr}

\tcbset{
  ipynb/.style={
    enlarge left by=\inwd,
    width=\linewidth-\inwd,
    enhanced,
    top=0pt,
    bottom=0pt,
    left=0pt,
    right=0pt,
  }
}

\tcbset{
  ipynbbox/.style={
    sharp corners,
    boxrule=0.4pt,
    colback=aqua3,
    frame hidden,
    %colframe=aqua,
  }
}

\tcbset{
  ipynboverlayin/.style={
    overlay={
      \node[
        anchor=north east,
        text width=\inwd,
        font=\footnotesize\ttfamily\color{aqua},
        inner ysep=6pt,
        inner xsep=0pt,
        outer sep=0pt
      ] 
      at (frame.north west)
      {[\theipythcntr]:};
    },
  },
}

\tcbset{
  ipynbminted/.style={
    listing only,
    listing engine=minted,
    minted language=python,
    minted style=friendly,
    minted options={
      fontsize=\scriptsize,
      breaklines=true
    }, 
  },
}

\newtcblisting[use counter=ipythcntr, number format=\arabic]{ipynbin}[1][]{
  ipynb,
  ipynbbox,
  ipynboverlayin,
  ipynbminted,
  #1,
}


\tcbset{
  ipynboverlayout/.style={
    overlay={
      \node[
        anchor=north east,
        text width=\inwd,
        font=\footnotesize\ttfamily\color{mydarkgreen},
        inner ysep=4pt,
        inner xsep=0pt,
        outer sep=0pt
      ] 
      at (frame.north west)
      {[\arabic{ipythcntr}]:};
    },
  },
 }

\tcbset{
  ipynbnobox/.style={
    standard jigsaw,
    opacityback=0,
    frame hidden,
  },
}

\newtcolorbox{ipynboutnocode}[1][]{
  ipynbnobox,
  ipynb,
  ipynboverlayout,
  top=-3pt,
  fontupper=\scriptsize\ttfamily,
  #1, 
}

\newtcblisting{ipynbout}[1][]{
  ipynbnobox,
  ipynb,
  ipynboverlayout,
  top=-3pt,
  fontupper=\scriptsize\ttfamily,
  listing only,
  listing engine=minted,
  minted language=text,
  minted options={
    fontsize=\scriptsize,
    breaklines=true
  },
  #1, 
}

\RequirePackage{setspace}
\renewcommand{\baselinestretch}{1.5}
\newtcolorbox{commentb}{%
  ipynbnobox, 
  ipynb,
  left=-4pt,
  fontupper={\small\linespread{0.66}\selectfont}
}

\newtcblisting[use counter=ipythcntr, number format=\arabic]{ipynbincommented}[2][]{
  ipynb,
  ipynbbox,
  ipynboverlayin,
  ipynbminted,
  listing above comment,
  middle=0pt,
  comment={
    \begin{commentb}
      #2
    \end{commentb}
  },
  #1,
}

\newtcblisting{ipynboutcommented}[2][]{
  ipynbnobox,
  ipynb,
  ipynboverlayout,
  top=-3pt,
  fontupper=\scriptsize\ttfamily,
  listing only,
  listing engine=minted,
  minted language=text,
  minted options={
    fontsize=\scriptsize,
    breaklines=true
  },
  listing above comment,
  middle=0pt,
  comment={
    \begin{commentb}
      #2
    \end{commentb}
  },
  #1,
}
