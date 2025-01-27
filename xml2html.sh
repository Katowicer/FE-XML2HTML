#!/bin/bash

xml2html() {
    local STYLE="$1"
    local XML_DIR="$2"
    local HTML_DIR="$3"
    local PDF_DIR="$4"
    local LOG_FILE="$5"
    local ERROR_LOG="$6"
    local TEMP=""

    if [[ ! -f "$LOG_FILE" ]]; then
        echo "Error: Log file '$LOG_FILE' not found!"
        return 1
    fi

    if [[ ! -f "$ERROR_LOG" ]]; then
        echo "Error: Error log file '$ERROR_LOG' not found!"
        return 1
    fi

    if [[ ! -f "$STYLE" ]]; then
        echo "Error: XSL file '$STYLE' not found!" | tee -a "$ERROR_LOG"
        return 1
    fi

    if [[ ! -d "$XML_DIR" ]]; then
        echo "Error: XML directory '$XML_DIR' not found!" | tee -a "$ERROR_LOG"
        return 1
    fi

    if [[ -z "$HTML_DIR" ]]; then
        TEMP=$(mktemp -d)
        HTML_DIR="$TEMP"
    fi

    for xml_file in "$XML_DIR"/*.xml; do
        base_name=$(basename "$xml_file" .xml)
        html_file="$HTML_DIR/$base_name.html"
        pdf_file="$PDF_DIR/$base_name.pdf"

        # Uncomment for debug and log files
        # echo " $base_name" >> "$LOG_FILE"
    
        xsltproc "$STYLE" "$xml_file" -o "$html_file" >> "$LOG_FILE" 2>> "$ERROR_LOG"

        if [[ -n "$PDF_DIR" ]]; then
            wkhtmltopdf "$html_file" "$pdf_file" >> "$LOG_FILE" 2>> "$ERROR_LOG"
        fi
    done

    rm -rf "$TEMP"
}

show_help() {
    echo "Usage: $0 -s STYLE -x XML_DIR [-h HTML_DIR] [-p PDF_DIR] -l LOG_FILE -e ERROR_LOG"
    echo
    echo "  -s STYLE        Path to the XSLT stylesheet (style.xsl)"
    echo "  -x XML_DIR      Directory containing XML files"
    echo "  -h HTML_DIR     Directory to store generated HTML files (optional)"
    echo "  -p PDF_DIR      Directory to store generated PDF files (optional)"
    echo "  -l LOG_FILE     Log file to capture standard output"
    echo "  -e ERROR_LOG    Log file to capture error output"
    echo "  -v              Show script version"
    echo "  --help          Show this help message"
    echo
    echo "Examples:"
    echo "  $0 -s style.xsl -x input -h output_html -l convert.log -e error.log"
    echo "  $0 -s style.xsl -x input -p output_pdf -l convert.log -e error.log"
    echo "  $0 -s style.xsl -x input -h output_html -p output_pdf -l convert.log -e error.log"
}

# CLI options
while getopts "s:x:h:p:l:e:v" opt; do
    case "$opt" in
        s) STYLE="$OPTARG" ;;
        x) XML_DIR="$OPTARG" ;;
        h) HTML_DIR="$OPTARG" ;;
        p) PDF_DIR="$OPTARG" ;;
        l) LOG_FILE="$OPTARG" ;;
        e) ERROR_LOG="$OPTARG" ;;
        v) echo "Script version 1.0"; exit 0 ;;
        *) show_help; exit 1 ;;
    esac
done

if [[ -z "$STYLE" || -z "$XML_DIR" || -z "$LOG_FILE" || -z "$ERROR_LOG" ]]; then
    echo "Error: Missing required arguments."
    show_help
    exit 1
fi

if [[ -z "$HTML_DIR" && -z "$PDF_DIR" ]]; then
    echo "Error: At least one of -h (HTML_DIR) or -p (PDF_DIR) must be specified."
    show_help
    exit 1
fi

xml2html "$STYLE" "$XML_DIR" "$HTML_DIR" "$PDF_DIR" "$LOG_FILE" "$ERROR_LOG"
