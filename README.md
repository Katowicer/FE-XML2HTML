# FE-XML2HTML

Easily convert Fatture Elettroniche in XML format to HTML and PDF formats.

## Testing
See branch [0002-SHELLTEST](https://github.com/Katowicer/FE-XML2HTML/tree/0002-SHELLTEST) and setup the testing environment via the [.env](https://github.com/Katowicer/FE-XML2HTML/blob/0002-SHELLTEST/.env) file

[![Built with Devbox](https://www.jetify.com/img/devbox/shield_moon.svg)](https://www.jetify.com/devbox/docs/contributor-quickstart/)

<!-- gen-readme start - generated by https://github.com/jetify-com/devbox/ -->
## Development Environemt
This project uses [devbox](https://github.com/jetify-com/devbox) to manage its development environment.

Install devbox:
```sh
curl -fsSL https://get.jetpack.io/devbox | bash
```

Start the devbox shell:
```sh 
devbox shell
```

Run a script in the devbox environment:
```sh
devbox run <script>
```
## Scripts
Scripts are custom commands that can be run using this project's environment. This project has the following scripts:

* [emesse](#devbox-run-emesse)
* [ricevute](#devbox-run-ricevute)

## Shell Init Hook
The Shell Init Hook is a script that runs whenever the devbox environment is instantiated. It runs 
on `devbox shell` and on `devbox run`.
```sh
chmod +x ./xml2html.sh
```

## Packages

* [libxslt@1.1.42](https://www.nixhub.io/packages/libxslt)
* [wkhtmltopdf@ 0.12.6.1-3](https://www.nixhub.io/packages/wkhtmltopdf)

## Script Details

### devbox run emesse
```sh
./xml2html.sh -s $STYLE -l $LOG_FILE -e $ERROR_FILE -x $XML_DIR_EMESSE -h $HTML_DIR_EMESSE -p $PDF_DIR_EMESSE
```
&ensp;

### devbox run ricevute
```sh
./xml2html.sh -s $STYLE -l $LOG_FILE -e $ERROR_FILE -x $XML_DIR_RICEVUTE -h $HTML_DIR -p $PDF_DIR_RICEVUTE
```
&ensp;

<!-- gen-readme end -->

## Using Docker
Use the provided [Dev Container](.devcontainer) or [Dockerfile](./Dockerfile)
See also the [.envrc](.envrc) file for [Direnv](https://direnv.net/) integration