% -----------------------------------------------------------------------------
% LaTeX class for the BSc/Msc thesis at the Departments of Earth
% and Planetary Sciences, ETH Zurich.
% 
% Jochen Wuttke <jwuttke@ethz.ch>
%
% THIS IS NOT AN OFFICIAL ETHZ CLASS. USE AT YOUR OWN RISK.
%
% -----------------------------------------------------------------------------
%%
%% This file is 'eapsthesis.cls'
%% 
%% It may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3c
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%    http://www.latex-project.org/lppl.txt
%% and version 1.3c or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.

%%% identification
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{eapsthesis}[2026/01/17 v. 0.1 %
 ETH D-EAPS thesis class]
%%% initial code
\RequirePackage{xifthen}
% Required to add ETH logos on the titlepage
\RequirePackage{graphicx}
% Set to true when the bscthesis option is used.
\newboolean{@bscthesis}
% Set to true when the mscthesis option is used.
\newboolean{@mscthesis}
% Default is BSc thesis
\setboolean{@bscthesis}{true}
\setboolean{@mscthesis}{false}
\DeclareOption{bscthesis}{
    \setboolean{@bscthesis}{true}
    \setboolean{@mscthesis}{false}
}
\DeclareOption{mscthesis}{
    \setboolean{@bscthesis}{false}
    \setboolean{@mscthesis}{true}
}
% Options to set whether the thesis should use a report format using only sections,
% or a book format using chapters. Defaults to book.
\newboolean{@book}
\newboolean{@report}
\setboolean{@book}{true}
\setboolean{@report}{false}
\DeclareOption{book}{
    \setboolean{@book}{true}
    \setboolean{@report}{false}
}
\DeclareOption{report}{
    \setboolean{@book}{false}
    \setboolean{@report}{true}
}
% Turns of hyperlink creation when set to true via the class option.
\newboolean{@nohyper}
\setboolean{@nohyper}{false}
\DeclareOption{nohyper}{
    \setboolean{@nohyper}{true}
}


% Disable existing options from the book and article classes that are not allowed for theses.
\DeclareOption{a5paper}{\OptionNotUsed}
\DeclareOption{letterpaper}{\OptionNotUsed}
\DeclareOption{b5paper}{\OptionNotUsed}
\DeclareOption{legalpaper}{\OptionNotUsed}
\DeclareOption{executivepaper}{\OptionNotUsed}
\DeclareOption{twocolumn}{\OptionNotUsed}
\DeclareOption{openany}{\OptionNotUsed}

% Process the given options and load the relevant document base class.
\DeclareOption*{% 
\PassOptionsToClass{\CurrentOption}{book}
} 
\ProcessOptions \relax
\typeout{*** Please report bugs, comments, suggestions, and improvements
to: }
\typeout{*** Jochen Wuttke <jwuttke@ethz.ch>}
%%% base class loading
\ifthenelse{\boolean{@book}}{\LoadClass[a4paper,onecolumn,openright,titlepage]{book}}{}
\ifthenelse{\boolean{@report}}{\LoadClass[a4paper,onecolumn,titlepage]{article}}{}

% Load packages required for basic class layout
% We need to load this before fancyhdr, because it sets head margins etc.
\RequirePackage[a4paper]{geometry}

\ifthenelse{\boolean{@nohyper}}{}{\RequirePackage{hyperref}}

%%% fancy headers
\RequirePackage{fancyhdr}
\setlength{\headheight}{15pt}
\fancypagestyle{cover}{%
  \fancyhf{}
  \fancyhead{\mbox{ }}
}
\fancypagestyle{hrulefpage}{%
  \fancyhf{}
   \fancyhead{\mbox{ }}
  \fancyfoot[C]{\sf \thepage}
}

% Student ID, displayed on the title page.
\newcommand{\studentid}[1]{\gdef\@studentid{#1}}
% Main advisor, displayed on the title page.
\newcommand{\mainadvisor}[3][Department of Earth and Planetary Sciences, ETH Zurich]
{\gdef\@maindep{#3}\gdef\@mainadvisor{#2}\gdef\@mainaff{#1}}
% Co-advisor, displayed on the title page.
\newcommand{\coadvisor}[3][Department of Earth and Planetary Sciences, ETH Zurich]
{\gdef\@coaff{#1}\gdef\@coadvisor{#2}\gdef\@codep{#3}}
% Examiner, displayed on the title page of the Master template.
\newcommand{\examiner}[3][Department of Earth and Planetary Sciences, ETH Zurich]
{\gdef\@exaff{#1}\gdef\@examiner{#2}\gdef\@exdep{#3}}
% Master Specialization
\newcommand{\specialization}[1]{\gdef\@specialization{#1}}

%% TODO: Examiner for MSc thesis.

% Page format required to twosided layout of BSc thesis (as of 2026-08-08)
% We set this univerally here, but the title page overrides this locally.
\ifthenelse{\boolean{@twoside}}{\geometry{a4paper,inner=3cm,outer=2cm,top=3cm,bottom=3cm}}
    {\geometry{a4paper,left=2.5cm,right=2.5cm,top=3cm,bottom=3cm}}

%%% title page
\renewcommand{\maketitle}
{%
    \begin{titlepage}%
    \pagestyle{empty}
    \newgeometry{inner=2.5cm,outer=3cm,top=1cm,bottom=1cm}
    \pagenumbering{Alph}
    \noindent \hspace*{-0.8cm}\includegraphics[scale=0.9]{eth-logo-pos.png}

    \vfill

    \begin{flushleft}
        \ifthenelse{\boolean{@bscthesis}}{\Large\textbf{Bachelor's Thesis}\\
        \vspace{1ex}
        
        \large Bachelor in Earth and Climate Sciences, Geology and Geophysics}{}
        \noindent\ifthenelse{\boolean{@mscthesis}}{\Large\textbf{Master's Thesis}\\
        \vspace{1ex}
        
        \large\@specialization}{}
    \end{flushleft}

    \vfill

    \noindent
    \begin{minipage}{\textwidth}%
        \hspace*{-\tabcolsep}{\large
        \begin{tabular}{p{4cm}l}
        presented by & \@author \\
        & \@studentid \\
        \end{tabular}
        }
    \end{minipage}

    \vfill

    {
    \noindent\begin{onehalfspace}%
    \LARGE {\bf \@title}
    \end{onehalfspace}
    }
    \vfill

    \noindent\begin{minipage}{\textwidth}%
        \hspace*{-\tabcolsep}{
            \begin{tabular}{p{4cm}l}
            Main supervisor & \@mainadvisor \\
                & \@maindep \\
                & \@mainaff \\    
                & \\
            Additional supervisor & \@coadvisor \\
                & \@codep \\
                & \@coaff \\
            \ifthenelse{\boolean{@mscthesis}}{\\
            Examiner & \@examiner \\
                & \@exdep \\
                & \@exaff \\}{}
            \end{tabular}
        }
    \end{minipage}


    \vfill
    \vfill

    \noindent\begin{minipage}{\textwidth}
        \hspace*{-\tabcolsep}{
        \begin{tabular}{p{4cm}l}
        handed in on & \@date\\
        \end{tabular}
        }
    \end{minipage}

    \vfill
    \vfill

    \noindent \includegraphics[scale=0.1]{eaps-logo.png}
    \end{titlepage}%
    \restoregeometry
} %%% end titlepage

% Reset stuff to defaults for the rest of the document and clear two pages (for twoside layout).
\renewenvironment{titlepage}
{%
\clearpage
  \setcounter{page}\z@
}%
{%
    \pagenumbering{roman}
    \clearpage

    \thispagestyle{empty}

    \mbox{ }

    \clearpage
    \setcounter{footnote}{0}
}%

%% The frontmatter is everything before the main text. 
% This includes abstract, table of contents and other optional things like lists of figures and tables,
% should they come in front. 
% The main thing is that the frontmatter uses a different number format for page numbers, and resets
% the counter when the mainmatter starts.
\ifthenelse{\boolean{@book}}{%
\renewcommand\frontmatter{%
    \@mainmatterfalse

    \pagestyle{empty}
    \pagenumbering{roman}
    \setcounter{page}{1}
    \pagestyle{hrulefpage}
    % Setting header formats. Should be the same as the rest of the text.
    \fancypagestyle{plain}{%
    \fancyhf{}
    \fancyfoot[C]{\thepage}
    \renewcommand{\headrulewidth}{0pt}}
    \pagestyle{fancy}
    \renewcommand{\chaptermark}[1]{\markboth{\ ##1}{}}
    \renewcommand{\sectionmark}[1]{\markright{\thesection\ ##1}}
    \fancyhead{}
    \ifthenelse{\boolean{@twoside}}{
        \fancyhead[RO, RE]{\rightmark}
        \fancyhead[LO, LE]{\thepage}
    }{
        \fancyhead[R]{\rightmark}
        \fancyhead[L]{\thepage}
    }
    \fancyfoot{}
} %%% end frontmatter

%%% "Abstract" environment. This will sit on its own page.
\newenvironment{abstract}[1][Abstract]{%
\section*{#1\markboth{#1}{}}
}{\cleardoublepage}  %% TODO: only cleardouble when twosided.

%%% put ToC, LoF, LoT and Index entries in the ToC
%%% use of \phantomsection is required for dealing with hyperref
%%% package and depends on nohyper option

\renewcommand\tableofcontents{%
    \ifthenelse{\boolean{@nohyper}}{}{\phantomsection}
    \addcontentsline{toc}{chapter}{\contentsname}%
    \chapter*{\contentsname
        \@mkboth{\contentsname}{\contentsname}}%
    \@starttoc{toc}%
    \cleardoublepage
}

\renewcommand\listoffigures{%
    \ifthenelse{\boolean{@nohyper}}{}{\phantomsection}%
    \addcontentsline{toc}{chapter}{\listfigurename}%
    \chapter*{\listfigurename}%
    \@mkboth{\listfigurename}%
            {\listfigurename}%
    \@starttoc{lof}%
    \cleardoublepage%
}

\renewcommand\listoftables{%
    \ifthenelse{\boolean{@nohyper}}{}{\phantomsection}%
    \addcontentsline{toc}{chapter}{\listtablename}%
    \chapter*{\listtablename}%
    \@mkboth{\listtablename}%
            {\listtablename}%
    \@starttoc{lot}%
    \cleardoublepage%
}

\RequirePackage[style=apa, backend=biber]{biblatex}
% Redefine print bibliography to add the bibliography to the table of contents.
\let\oldbib=\printbibliography
\renewcommand{\printbibliography}{
    \addcontentsline{toc}{chapter}{\bibname}
    \oldbib
    \cleardoublepage
}

%%% "Acknowledgments" environment. This will sit on its own page.
\newenvironment{acknowledgements}{%
\ifthenelse{\boolean{@nohyper}}{}{\phantomsection}
\addcontentsline{toc}{chapter}{Acknowledgements}%
\section*{Acknowledgements\markboth{Acknowledgements}{}}
}{\cleardoublepage}  %% TODO: only cleardoublepage in twosided

}{}

\ifthenelse{\boolean{@report}}{%
\newcommand\frontmatter{%
    \pagestyle{empty}
    \pagenumbering{roman}
    \setcounter{page}{1}
    \pagestyle{hrulefpage}
    % Setting header formats. Should be the same as the rest of the text.
    \fancypagestyle{plain}{%
    \fancyhf{}
    \fancyfoot[C]{\thepage}
    \renewcommand{\headrulewidth}{0pt}}
    \pagestyle{fancy}
    \renewcommand{\sectionmark}[1]{\markright{\thesection\ ##1}}
    \fancyhead{}
    \ifthenelse{\boolean{@twoside}}{
        \fancyhead[RO, RE]{\rightmark}
        \fancyhead[LO, LE]{\thepage}
    }{
        \fancyhead[R]{\rightmark}
        \fancyhead[L]{\thepage}
    }
    \fancyfoot{}
} %%% end frontmatter

\newcommand\mainmatter{
    \pagenumbering{arabic}
}

\newcommand\backmatter{}

%%% "Abstract" environment. This will sit on its own page.
\renewenvironment{abstract}[1][Abstract]{%
\section*{#1\markboth{#1}{}}
}{\cleardoublepage}  %% TODO: only cleardouble when twosided.

%%% put ToC, LoF, LoT and Index entries in the ToC
%%% use of \phantomsection is required for dealing with hyperref
%%% package and depends on nohyper option

\renewcommand\tableofcontents{%
    \ifthenelse{\boolean{@nohyper}}{}{\phantomsection}
    \addcontentsline{toc}{section}{\contentsname}%
    \section*{\contentsname
        \@mkboth{\contentsname}{\contentsname}}%
    \@starttoc{toc}%
    \cleardoublepage
}

\renewcommand\listoffigures{%
    \ifthenelse{\boolean{@nohyper}}{}{\phantomsection}
    \addcontentsline{toc}{section}{\listfigurename}%
    \section*{\listfigurename}%
      \@mkboth{\listfigurename}%
              {\listfigurename}%
    \@starttoc{lof}%
    \cleardoublepage
}

\renewcommand\listoftables{%
    \ifthenelse{\boolean{@nohyper}}{}{\phantomsection}
    \addcontentsline{toc}{section}{\listtablename}%
    \section*{\listtablename}%
      \@mkboth{%
          \listtablename}%
         {\listtablename}%
    \@starttoc{lot}%
}

\RequirePackage[style=apa, backend=biber]{biblatex}
% Redefine print bibliography to add the bibliography to the table of contents.
\let\oldbib=\printbibliography
\renewcommand{\printbibliography}{
    \addcontentsline{toc}{section}{\bibname}
    \oldbib
    \cleardoublepage
}

%%% "Acknowledgments" environment. This will sit on its own page.
\newenvironment{acknowledgements}{%
\ifthenelse{\boolean{@nohyper}}{}{\phantomsection}
\addcontentsline{toc}{section}{Acknowledgements}%
\section*{Acknowledgements\markboth{Acknowledgements}{}}
}{\cleardoublepage}  %% TODO: only cleardoublepage in twosided
}{}
  

%%% "Abstract" environment. This will sit on its own page.


