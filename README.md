# Criando um Instalador com Inno Setup

Este guia explica como criar um instalador para o programa "Extrato de Pagamento" utilizando o Inno Setup. Siga os passos abaixo para configurar e gerar o instalador.

---

## Pré-requisitos

1. **Baixar e instalar o Inno Setup**:
   - Acesse o site oficial do [Inno Setup](https://jrsoftware.org/isinfo.php) e faça o download.
   - Instale o Inno Setup no seu computador.

2. **Estrutura do projeto**:
   - Certifique-se de que o programa "Extrato de Pagamento" está devidamente empacotado em um diretório, como `dist\extrato_pagamento`.
   - Inclua todos os arquivos necessários, como o executável (`extrato_pagamento.exe`), planilhas Excel, ícones e outros recursos.

3. **Arquivo de script do Inno Setup**:
   - Crie um arquivo de script `.iss` (como `setup_script.iss`) e insira o código fornecido.

---

Claro! Vou detalhar melhor a criação do código do script do Inno Setup, explicando cada seção e como configurá-la.

---

## **Passo a Passo Detalhado para Criar o Código do Script**

O script do Inno Setup é dividido em várias seções. Abaixo, explico cada uma delas e como configurá-las para criar o instalador.

---

### **1. Seção `[Setup]`**

A seção `[Setup]` define as configurações gerais do instalador, como o nome do programa, versão, diretório de instalação, ícone do instalador, entre outros.

```ini
[Setup]
AppName=Extrato de Pagamento
AppVersion=1.0
DefaultDirName={localappdata}\extrato_pagamento
DefaultGroupName=Extrato de Pagamento
OutputBaseFilename=ExtratoPagamentoSetup
Compression=lzma
SolidCompression=yes
PrivilegesRequired=lowest
SetupIconFile="C:\python\extrato_pagamento\dist\extrato_pagamento\_internal\sifama.ico"
```

- **`AppName`**: Nome do programa que será exibido no instalador.
- **`AppVersion`**: Versão do programa.
- **`DefaultDirName`**: Diretório padrão onde o programa será instalado. Aqui usamos `{localappdata}` para instalar na pasta de dados do usuário.
- **`DefaultGroupName`**: Nome do grupo de atalhos no menu Iniciar.
- **`OutputBaseFilename`**: Nome do arquivo do instalador gerado (sem a extensão `.exe`).
- **`Compression`**: Método de compressão dos arquivos. O `lzma` é eficiente e reduz o tamanho do instalador.
- **`SolidCompression`**: Ativa a compressão sólida para melhorar a compactação.
- **`PrivilegesRequired`**: Define o nível de privilégio necessário para instalar. `lowest` permite que o instalador seja executado sem privilégios de administrador.
- **`SetupIconFile`**: Caminho para o ícone do instalador.

---

### **2. Seção `[Files]`**

A seção `[Files]` especifica os arquivos que serão incluídos no instalador e onde eles serão instalados.

```ini
[Files]
Source: "C:\python\extrato_pagamento\dist\extrato_pagamento\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs
```

- **`Source`**: Caminho para os arquivos do programa que serão incluídos no instalador. O caractere `*` indica que todos os arquivos e subdiretórios serão incluídos.
- **`DestDir`**: Diretório de destino onde os arquivos serão instalados. `{app}` é uma variável que representa o diretório de instalação escolhido pelo usuário.
- **`Flags`**:
  - `ignoreversion`: Ignora a verificação de versão dos arquivos.
  - `recursesubdirs`: Inclui subdiretórios automaticamente.

---

### **3. Seção `[Languages]`**

Define o idioma do instalador. Aqui, configuramos para usar o português.

```ini
[Languages]
Name: "portuguese"; MessagesFile: "compiler:Languages\Portuguese.isl"
```

- **`Name`**: Nome do idioma.
- **`MessagesFile`**: Arquivo de mensagens do idioma. O Inno Setup já inclui o arquivo `Portuguese.isl`.

---

### **4. Seção `[Icons]`**

Cria atalhos no desktop e no menu Iniciar.

```ini
[Icons]
Name: "{userdesktop}\Extrato de Pagamento"; Filename: "{app}\extrato_pagamento.exe"
Name: "{group}\Desinstalar Extrato de Pagamento"; Filename: "{uninstallexe}"
Name: "{userdesktop}\Autos de Infração"; Filename: "{app}\_internal\excel\Autos de Infração.xlsx"
Name: "{userdesktop}\Planilha Resultado"; Filename: "{app}\_internal\excel\Planilha Resultado.xlsx"
Name: "{userdesktop}\Download extrato"; Filename: "{app}\_internal\download_extrato"
```

- **`Name`**: Nome do atalho. `{userdesktop}` cria o atalho na área de trabalho, e `{group}` cria no menu Iniciar.
- **`Filename`**: Caminho do arquivo que será aberto pelo atalho.
- **`{uninstallexe}`**: Representa o desinstalador do programa.

---

### **5. Seção `[Code]`**

Adiciona lógica personalizada ao instalador. Aqui, criamos duas páginas personalizadas: uma para exibir informações importantes e outra para os Termos de Uso.

---

### **7. Compilação**

1. Abra o Inno Setup.
2. Cole o código completo no editor.
3. Clique em **Compile** (ou pressione `F9`).
4. O instalador será gerado no mesmo diretório do script.

---

Seguindo esses passos detalhados, você terá um instalador funcional e personalizado para o programa "Extrato de Pagamento".
