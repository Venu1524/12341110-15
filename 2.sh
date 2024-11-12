!/bin/bash


if [ $# -lt 1 ]; then
  echo "Usage: $0 <input_file.csv>"
  exit 1
fi


INPUT_FILE=$1
OUTPUT_TEX="output.tex"


cat <<EOF > $OUTPUT_TEX
\documentclass{article}
\usepackage{longtable}
\usepackage{geometry}
\geometry{a4paper, margin=1in}
\begin{document}

\title{Generated Table from CSV}
\author{}
\date{}
\maketitle

\section*{Table Generated from CSV Data}
\begin{longtable}{|c|c|c|c|}  % Adjust the number of columns if necessary
\hline
EOF


while IFS=, read -r col1 col2 col3 col4; do
  # Print column data into LaTeX table format
  echo "$col1 & $col2 & $col3 & $col4 \\\\" >> $OUTPUT_TEX
  echo "\hline" >> $OUTPUT_TEX
done < "$INPUT_FILE"


cat <<EOF >> $OUTPUT_TEX
\end{longtable}

\end{document}
EOF


echo "LaTeX table file generated: $OUTPUT_TEX"

