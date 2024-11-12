!/bin/bash

# Ensure we have a file input
if [ $# -lt 1 ]; then
  echo "Usage: $0 <input_file.csv>"
  exit 1
fi

# Input CSV file
INPUT_FILE=$1
OUTPUT_TEX="output.tex"

# Start the LaTeX document
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

# Process the CSV file to create LaTeX table rows
while IFS=, read -r col1 col2 col3 col4; do
  # Print column data into LaTeX table format
  echo "$col1 & $col2 & $col3 & $col4 \\\\" >> $OUTPUT_TEX
  echo "\hline" >> $OUTPUT_TEX
done < "$INPUT_FILE"

# End the LaTeX document
cat <<EOF >> $OUTPUT_TEX
\end{longtable}

\end{document}
EOF

# Optional: Compile LaTeX to PDF
# Uncomment the following line to compile automatically
# pdflatex $OUTPUT_TEX

echo "LaTeX table file generated: $OUTPUT_TEX"

