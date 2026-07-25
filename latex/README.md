### Compilando o texto no linux:

## intale o texlive
sudo apt update && apt install --no-install-recommends -y texlive-full

##
Usando um terminal, navegue até a pasta *latex* 
```bash
cd latex
```

e execute o seguinte comando:

```bash
./ compile.sh principal
```

Os arquivos PDFs e LOGs serão gerados na pasta *build*.