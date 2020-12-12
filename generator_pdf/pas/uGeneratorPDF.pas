unit uGeneratorPDF;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, PReport, PdfDoc,
  Vcl.StdCtrls, Vcl.Buttons, ShellAPI, Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    PReport1: TPReport;
    PRPage1: TPRPage;
    PRLayoutPanel1: TPRLayoutPanel;
    PRText1: TPRText;
    PRText2: TPRText;
    PRText3: TPRText;
    PRText4: TPRText;
    txtCurso: TPRText;
    txtInstrutor: TPRText;
    txtObjGeral: TPRText;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    edtNomeCurso: TEdit;
    edtNomeInstrutor: TEdit;
    edtObjGeral: TEdit;
    GroupBox1: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    rgNivel: TRadioGroup;
    rgTipoCurso: TRadioGroup;
    edtPublicoAlvo: TEdit;
    edtRequisitos: TEdit;
    edtCargaHoraria: TEdit;
    edtNumVagas: TEdit;
    Button5: TButton;
    TabSheet2: TTabSheet;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    reEmenta: TRichEdit;
    reInstrumentos: TRichEdit;
    reMetodologia: TRichEdit;
    Button4: TButton;
    TabSheet3: TTabSheet;
    Label16: TLabel;
    Label17: TLabel;
    reProcessoAvaliativo: TRichEdit;
    reReferencia: TRichEdit;
    PRLayoutPanel2: TPRLayoutPanel;
    PRText5: TPRText;
    txtNivel: TPRText;
    txttcurso: TPRText;
    txtTipoCurso: TPRText;
    txtlabelalvo: TPRText;
    txtPublicoAlvo: TPRText;
    txtlabelmin: TPRText;
    txtReqMin: TPRText;
    txtlabelcurso: TPRText;
    txtHorCurso: TPRText;
    txtlabelch: TPRText;
    txtCargHoraria: TPRText;
    txtQuantidade: TPRText;
    txtQuantidadeVagas: TPRText;
    PRLayoutPanel3: TPRLayoutPanel;
    txtEmenta: TPRText;
    PRText7: TPRText;
    PRText6: TPRText;
    txtInstrumentos: TPRText;
    txtMetodologia: TPRText;
    PRText9: TPRText;
    txtProcessoAvaliativo: TPRText;
    PRText10: TPRText;
    txtReferencias: TPRText;
    PRText11: TPRText;
    btGerarPDF: TBitBtn;
    Button6: TButton;
    GroupBox2: TGroupBox;
    Button1: TButton;
    Button3: TButton;
    BitBtn1: TBitBtn;
    Label1: TLabel;
    Label10: TLabel;
    Label3: TLabel;
    edtHoraInicio: TEdit;
    edtHoraFinal: TEdit;
    PRText8: TPRText;
    txtDataFinal: TPRText;
    PRText12: TPRText;
    txtHoraInicio: TPRText;
    PRText13: TPRText;
    txtHorarioFinal: TPRText;
    Label2: TLabel;
    dtpDataCursoInicio: TDateTimePicker;
    dtpDataFinal: TDateTimePicker;
    procedure btGerarPDFClick(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btGerarPDFClick(Sender: TObject);
var
  NomeArquivo : string;
begin
  try
    NomeArquivo := 'Teste';

    //Passando os valores dos edits
    txtCurso.Text := edtNomeCurso.Text;
    txtInstrutor.Text := edtNomeInstrutor.Text;
    txtObjGeral.Text := edtObjGeral.Text;

    //N�vel do curso
    if(rgNivel.ItemIndex = 0) then
      begin
        txtNivel.Text := 'B�sico';
      end
    else
    if (rgNivel.ItemIndex = 1) then
      begin
        txtNivel.Text := 'Intermedi�rio';
      end
    else
        txtNivel.Text := 'Avan�ado';

    //Tipo de curso
    if(rgTipoCurso.ItemIndex = 0) then
      begin
        txtTipoCurso.Text := 'Te�rico';
      end
    else
    if (rgTipoCurso.ItemIndex = 1) then
      begin
        txtTipoCurso.Text := 'Pr�tico';
      end
    else
        txtTipoCurso.Text := 'Te�rico-Pr�tico';

    //Passando os valores dos edits
     txtPublicoAlvo.Text := edtPublicoAlvo.Text;
     txtReqMin.Text := edtRequisitos.Text;
     txtHorCurso.Text := DateToStr(dtpDataCursoInicio.Date);
     txtDataFinal.Text := DateToStr(dtpDataFinal.Date);
     txtCargHoraria.Text := edtCargaHoraria.Text;
     txtHoraInicio.Text := edtHoraInicio.Text;
     txtHorarioFinal.Text := edtHoraFinal.Text;
     txtQuantidadeVagas.Text := edtNumVagas.Text;

    //Passando os valores dos RichEdits
     txtEmenta.Lines := reEmenta.Lines;
     txtInstrumentos.Lines := reInstrumentos.Lines;
     txtMetodologia.Lines := reMetodologia.Lines;
     txtProcessoAvaliativo.Lines := reProcessoAvaliativo.Lines;
     txtReferencias.Lines := reReferencia.Lines;

    // Gera e visualiza o PDF
    PReport1.FileName:=ExtractFilePath(Application.ExeName)+'Arquivos\'+NomeArquivo+'.pdf';
    PReport1.BeginDoc;
    PReport1.Print(PRPage1);
    PReport1.EndDoc;

    //Caso queira visualizar logo ao gerar... se n�o � s� comentar essa linha de baixo
    ShellExecute(Handle,'open',PChar(ExtractFilePath(Application.ExeName)+'Arquivos\'+NomeArquivo+'.pdf'),nil,nil,SW_SHOWNORMAL);
  except on E:Exception do
    ShowMessage(E.Message);
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
pageControl1.ActivePage := TabSheet2;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
Form1.Close;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
pageControl1.ActivePage := TabSheet3;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
pageControl1.ActivePage := TabSheet2;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
pageControl1.ActivePage := TabSheet1;
end;

end.
