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

% Disable existing options from the book and article classes that are not allowed for theses.
\DeclareOption{a5paper}{\OptionNotUsed}
\DeclareOption{letterpaper}{\OptionNotUsed}
\DeclareOption{b5paper}{\OptionNotUsed}
\DeclareOption{legalpaper}{\OptionNotUsed}
\DeclareOption{executivepaper}{\OptionNotUsed}
\DeclareOption{twocolumn}{\OptionNotUsed}

% Process the given options and load the relevant document base class.
\ProcessOptions \relax
\typeout{*** Please report bugs, comments, suggestions, and improvements
  to: }
\typeout{*** Jochen Wuttke <jwuttke@ethz.ch>}
%%% base class loading
\LoadClass[a4paper,twoside,onecolumn,openright,titlepage]{book}

% Load packages required for basic class layout
% We need to load this before fancyhdr, because it sets head margins etc.
\RequirePackage[a4paper]{geometry}

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
\newcommand{\mainadvisor}[2]{\gdef\@mainadvisor{#1}\gdef\@mainaff{#2}}
% Co-advisor, displayed on the title page.
\newcommand{\coadvisor}[2]{\gdef\@coadvisor{#1}\gdef\@coaff{#2}}
% Master Specialization
\newcommand{\specialization}[1]{\gdef\@specialization{#1}}

%% TODO: Examiner for MSc thesis.

% Page format required to twosided layout of BSc thesis (as of 2026-08-08)
% We set this univerally here, but the title page overrides this locally.
\geometry{a4paper,inner=3cm,outer=2cm,top=3cm,bottom=3cm}

%%% title page
\renewcommand{\maketitle}
{\pagenumbering{Alph}
\begin{titlepage}%
  \pagestyle{empty}
\newgeometry{inner=2cm,outer=3cm,top=1cm,bottom=1cm}
\noindent \hspace*{-0.8cm}\includegraphics[scale=0.9]{eth-logo-pos.png}

\vfill

\noindent\ifthenelse{\boolean{@bscthesis}}{\Large\textbf{Bachelor's Thesis}\\
\\
\large Bachelor in Earth and Climate Sciences, Geology and Geophysics}{}
\ifthenelse{\boolean{@mscthesis}}{\Large\textbf{Master's Thesis}\\
\\
\large Master in \@specialization
}{}\\

\vfill

{\large
\noindent\begin{tabular}{p{4cm}l}
presented by & \@author \\
& \@studentid \\
\end{tabular}
}

\vfill

{
\setstretch{1.5}
\noindent {\LARGE {\bf \@title}}\\
}
\vfill
\vfill


\noindent\begin{tabular}{p{4cm}l}
    Main supervisor & \@mainadvisor \\
     & \@mainaff \\
     & Department of Earth and Planetary Sciences, ETH Zurich \\    
     & \\
    Additional supervisor & \@coadvisor \\
    & \@coaff \\
    & Department of Earth and Planetary Sciences, ETH Zurich \\
  \end{tabular}


\vfill
\vfill

\noindent\begin{tabular}{p{4cm}l}
    handed in on & \@date\\
\end{tabular}

\vfill
\vfill

\noindent \includegraphics[scale=0.1]{eaps-logo.png}
\end{titlepage}%
} %%% end titlepage

% Reset stuff to defaults for the rest of the document and clear two pages (for twoside layout).
\renewenvironment{titlepage}
{%
\clearpage
  \setcounter{page}\z@
}%
{%
    \pagenumbering{Roman}
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
    \fancyhead[RO, RE]{\rightmark}
    \fancyhead[LO, LE]{\thepage}
    \fancyfoot{}
} %%% end frontmatter
  

%%% "Abstract" environment. This will sit on its own page.
\newenvironment{abstract}[1][Abstract]{%
\section*{#1\markboth{#1}{}}
}{\cleardoublepage}  %% TODO: only cleardouble when twosided.

%%% "Acknowledgments" environment. This will sit on its own page.
\newenvironment{acknowledgements}{%
\section*{Acknowledgements\markboth{Acknowledgements}{}}
}{\cleardoublepage}  %% TODO: only cleardoublepage in twosided


%%% put ToC, LoF, LoT and Index entries in the ToC
%%% use of \phantomsection is required for dealing with hyperref
%%% package and depends on nohyper option

\renewcommand\listoffigures{%
% \ifthenelse{\boolean{@hypermode}}{\phantomsection}{}
    \addcontentsline{toc}{chapter}{List of \listfigurename}%
    \chapter*{\listfigurename}%
      \@mkboth{\listfigurename}%
              {\listfigurename}%
    \@starttoc{lof}%
    \cleardoublepage
}

\renewcommand\listoftables{%
% \ifthenelse{\boolean{@hypermode}}{\phantomsection}{}
\addcontentsline{toc}{chapter}{List of \listtablename}%
    \chapter*{\listtablename}%
      \@mkboth{%
          \listtablename}%
         {\listtablename}%
    \@starttoc{lot}%
}

\RequirePackage[style=apa, backend=biber]{biblatex}
% Redefine print bibliography to add the bibliography to the table of contents.
\let\oldbib=\printbibliography
\renewcommand{\printbibliography}{
    \addcontentsline{toc}{chapter}{\bibname}
    \oldbib
    \cleardoublepage
}