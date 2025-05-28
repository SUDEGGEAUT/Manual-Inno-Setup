[Setup]
AppName=Nome do Programa
AppVersion=1.0.0  ; Versão do programa. Idealmente usar a tag do Git correspondente.
DefaultDirName={localappdata}\NomeDaPasta  ; Caminho padrão onde o programa será instalado.
DefaultGroupName=Nome do Grupo no Menu Iniciar
OutputBaseFilename=EditalINSetup  ; Nome do arquivo .exe gerado após compilar

; NÃO ALTERAR AS CONFIGURAÇÕES ABAIXO
Compression=lzma
SolidCompression=yes
PrivilegesRequired=lowest

[Files]
Source: "C:\CAMINHO\PARA\PASTA\RAIZ\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs
; Importante: mantenha o "\*" no final do caminho para incluir todos os arquivos e subpastas da pasta raiz do seu programa.

[Languages]
Name: "portuguese"; MessagesFile: "compiler:Languages\Portuguese.isl"
; Define o idioma padrão do instalador como Português.

[Icons]
; Atalhos padrão
Name: "{userdesktop}\Nome do Programa"; Filename: "{app}\SeuPrograma.exe"
Name: "{usersdesktop}\Desinstalar Nome do Programa"; Filename: "{uninstallexe}"

; Atalhos opcionais - só use se o programa gera arquivos nessas pastas
Name: "{userdesktop}\1. EDITAIS DO DIA"; Filename: "{app}\_internal\1. EDITAIS DO DIA"
Name: "{userdesktop}\2. ENVIADOS DOU"; Filename: "{app}\_internal\2. ENVIADOS DOU"
Name: "{userdesktop}\3. EDITAIS COM ERROS"; Filename: "{app}\_internal\3. EDITAIS COM ERROS"
Name: "{userdesktop}\4. RECIBOS DOU"; Filename: "{app}\_internal\4. RECIBOS DOU"

[Code]
var
  CustomPage: TWizardPage;
  TermsPage: TInputOptionWizardPage;
  MemoText: TMemo;

procedure InitializeWizard;
begin
  // Página personalizada com informações do programa
  CustomPage := CreateCustomPage(wpWelcome, 'Informações Importantes', 'Leia as informações abaixo antes de continuar.');
  MemoText := TMemo.Create(CustomPage);
  MemoText.Parent := CustomPage.Surface;
  MemoText.ScrollBars := ssVertical;
  MemoText.ReadOnly := True;
  MemoText.WordWrap := True;
  MemoText.TabStop := False;
  MemoText.Text :=
    'Este programa não armazena nenhuma informação como Login, Senha ou dados sensíveis, respeitando a LGPD. ' +
    'Ele foi desenvolvido para automatizar (DESCREVA A FUNÇÃO DO PROGRAMA), permitindo verificar o envio de editais e gerar relatórios em log.' + #13#10#13#10 +
    '1. Uso Responsável: Utilize o programa apenas para fins autorizados e legais.' + #13#10#13#10 +
    '2. Limitação de Responsabilidade: O desenvolvedor não se responsabiliza por danos causados pelo uso do programa.' + #13#10#13#10 +
    '3. Privacidade e Segurança: O uso de credenciais é de responsabilidade do usuário.';

  MemoText.SetBounds(10, 10, CustomPage.SurfaceWidth - 20, CustomPage.SurfaceHeight - 20);

  // Página de aceitação dos termos
  TermsPage := CreateInputOptionPage(CustomPage.ID,
    'Termos de Uso',
    'Leia e aceite os Termos de Uso para continuar',
    'Você deve aceitar os Termos de Uso para instalar o programa.',
    True, False);
  TermsPage.Add('Eu li e aceito os Termos de Uso.');
  TermsPage.Values[0] := False;
end;

function NextButtonClick(CurPageID: Integer): Boolean;
begin
  if CurPageID = TermsPage.ID then
  begin
    if not TermsPage.Values[0] then
    begin
      MsgBox('Para instalar este programa, é necessário aceitar os Termos de Uso.', mbError, MB_OK);
      Result := False;
      Exit;
    end;
  end;
  Result := True;
end;

[Run]
; Abre o manual do programa após a instalação
Filename: "{app}\_internal\README.pdf"; Description: "Abrir instruções do programa"; Flags: postinstall shellexec skipifsilent
