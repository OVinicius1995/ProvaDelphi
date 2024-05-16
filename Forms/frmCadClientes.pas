unit frmCadClientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.Mask, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Buttons;

type
  TfrmCadUser = class(TForm)
    DataSource1: TDataSource;
    dbDados: TDBGrid;
    DBNavigator1: TDBNavigator;
    btnPesquisar: TButton;
    btnCadastrar: TButton;
    pnlTitulo: TPanel;
    lblTitulo: TLabel;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    lblNome: TLabel;
    lblTelefone: TLabel;
    lblLogradouro: TLabel;
    edtNome: TEdit;
    edtTelefone: TEdit;
    edtLogradouro: TEdit;
    lblSexo: TLabel;
    cmbSexo: TComboBox;
    btnAtualizar: TButton;
    btnDeletar: TButton;
    btnSair: TBitBtn;
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnCadastrarClick(Sender: TObject);
    procedure dbDadosCellClick(Column: TColumn);
    procedure btnAtualizarClick(Sender: TObject);
    procedure btnDeletarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
  private
    { Private declarations }
  procedure limparCampos();
  procedure atualizaGrid();
  public
    { Public declarations }
  end;

var
  frmCadUser: TfrmCadUser;

implementation

{$R *.dfm}

uses DmCli;

procedure TfrmCadUser.atualizaGrid;
begin
      DmCadCli.queryClientes.SQL.Add('');
      DmCadCli.queryClientes.SQL.Clear();
      DmCadCli.queryClientes.SQL.Add('SELECT * FROM USUARIOS');
      DmCadCli.queryClientes.Open();
end;

procedure TfrmCadUser.limparCampos;
begin
      edtNome.clear;
      edtTelefone.clear;
      edtLogradouro.clear;
      cmbSexo.clear;
      edtNome.SetFocus;
      btnAtualizar.Enabled := false;

end;

procedure TfrmCadUser.btnPesquisarClick(Sender: TObject);
begin
  atualizaGrid();
end;

procedure TfrmCadUser.btnCadastrarClick(Sender: TObject);
begin
      try

      DmCadCli.queryClientes.SQL.Add('');
      DmCadCli.queryClientes.SQL.Clear();
      DmCadCli.queryClientes.SQL.Add('INSERT INTO USUARIOS');
      DmCadCli.queryClientes.SQL.Add('(NOME,TELEFONE,LOGRADOURO,SEXO)');
      DmCadCli.queryClientes.SQL.Add('values (:Nome,:Tel,:Log,:Sexo)');

      DmCadCli.queryClientes.ParamByName('Nome').AsString := edtNome.Text;
      DmCadCli.queryClientes.ParamByName('Tel').AsString  := edtTelefone.Text;
      DmCadCli.queryClientes.ParamByName('Log').AsString  := edtLogradouro.Text;
      DmCadCli.queryClientes.ParamByName('Sexo').AsString := cmbSexo.Text;

      DmCadCli.queryClientes.ExecSQL;

      Application.MessageBox('Cadastrado com sucesso','Cadastro!', MB_OK + MB_ICONINFORMATION);

      limparCampos;
      atualizaGrid();

      except

      Application.MessageBox('Cadastrado abortado verifique!','Erro!', MB_ICONERROR);

      end;

end;




procedure TfrmCadUser.dbDadosCellClick(Column: TColumn);
begin
     edtNome.Text       := dbDados.Fields[1].Text;
     edtTelefone.Text   := dbDados.Fields[2].Text;
     edtLogradouro.Text := dbDados.Fields[3].Text;
     cmbSexo.Text       := dbDados.Fields[4].Text;

     btnAtualizar.Enabled := true;

end;

procedure TfrmCadUser.btnAtualizarClick(Sender: TObject);
begin

    if edtNome.Text <> DmCadCli.queryClientesNOME.Text then
    begin
        Application.MessageBox('Aten��o voc� est� alterando o campo nome desse registro','Cadastro!', MB_OK + MB_ICONWARNING);

        if Application.MessageBox('Deseja prosseguir com a altera��o?','Corre��o de campos.',MB_YESNOCANCEL + MB_ICONQUESTION) = mrYes then
        begin
            try

            if edtNome.Text = '' then
            begin
               Application.MessageBox('Aten��o o campo ficou em branco','Verifique!', MB_OK + MB_ICONWARNING);
            end

            else
            begin

            var getId := dbDados.Fields[0].AsInteger;

            DmCadCli.queryClientes.SQL.Add('');
            DmCadCli.queryClientes.SQL.Clear();
            DmCadCli.queryClientes.SQL.Add('UPDATE USUARIOS SET NOME = :AltNome');
            DmCadCli.queryClientes.SQL.Add('where ID ='+getId.ToString);

            DmCadCli.queryClientes.ParamByName('AltNome').AsString := edtNome.Text;

            DmCadCli.queryClientes.ExecSQL;

            Application.MessageBox('Campo nome atualizado com sucesso!','Altera��o!', MB_OK + MB_ICONINFORMATION);

            limparCampos;
            atualizaGrid();

            end;

            except
            begin
              Application.MessageBox('Opera��o n�o realizada verifique!','Altera��o!', MB_OK + MB_ICONINFORMATION);
            end;

            end;
        end;
    end;

    if edtTelefone.Text <> DmCadCli.queryClientesTELEFONE.Text then
    begin
        Application.MessageBox('Aten��o voc� est� alterando o campo telefone desse registro','Cadastro!', MB_OK + MB_ICONWARNING);

        if Application.MessageBox('Deseja prosseguir com a altera��o?','Corre��o de campos.',MB_YESNOCANCEL + MB_ICONQUESTION) = mrYes then
        begin
            try
            var getId := dbDados.Fields[0].AsInteger;

            DmCadCli.queryClientes.SQL.Add('');
            DmCadCli.queryClientes.SQL.Clear();
            DmCadCli.queryClientes.SQL.Add('UPDATE USUARIOS SET TELEFONE = :AltTelefone');
            DmCadCli.queryClientes.SQL.Add('where ID ='+getId.ToString);

            DmCadCli.queryClientes.ParamByName('AltTelefone').AsString := edtTelefone.Text;

            DmCadCli.queryClientes.ExecSQL;

            Application.MessageBox('Campo telefone atualizado com sucesso!','Altera��o!', MB_OK + MB_ICONINFORMATION);

            limparCampos;
            atualizaGrid();

            except
            begin
              Application.MessageBox('Opera��o n�o realizada verifique!','Altera��o!', MB_OK + MB_ICONINFORMATION);
            end;

            end;
        end;
    end;

    if edtLogradouro.Text <> DmCadCli.queryClientesLOGRADOURO.Text then
    begin
        Application.MessageBox('Aten��o voc� est� alterando o campo logradouro desse registro','Cadastro!', MB_OK + MB_ICONWARNING);

        if Application.MessageBox('Deseja prosseguir com a altera��o?','Corre��o de campos.',MB_YESNOCANCEL + MB_ICONQUESTION) = mrYes then
        begin
            try
            var getId := dbDados.Fields[0].AsInteger;

            DmCadCli.queryClientes.SQL.Add('');
            DmCadCli.queryClientes.SQL.Clear();
            DmCadCli.queryClientes.SQL.Add('UPDATE USUARIOS SET LOGRADOURO = :Altlogradouro');
            DmCadCli.queryClientes.SQL.Add('where ID ='+getId.ToString);

            DmCadCli.queryClientes.ParamByName('Altlogradouro').AsString := edtLogradouro.Text;

            DmCadCli.queryClientes.ExecSQL;

            Application.MessageBox('Campo logradouro atualizado com sucesso!','Altera��o!', MB_OK + MB_ICONINFORMATION);

            limparCampos;
            atualizaGrid();

            except
            begin
              Application.MessageBox('Opera��o n�o realizada verifique!','Altera��o!', MB_OK + MB_ICONINFORMATION);
            end;

            end;
        end;
    end;

        if cmbSexo.Text <> DmCadCli.queryClientesSEXO.Text then
    begin
        Application.MessageBox('Aten��o voc� est� alterando o campo sexo desse registro','Cadastro!', MB_OK + MB_ICONWARNING);

        if Application.MessageBox('Deseja prosseguir com a altera��o?','Corre��o de campos.',MB_YESNOCANCEL + MB_ICONQUESTION) = mrYes then
        begin
            try
            var getId := dbDados.Fields[0].AsInteger;

            DmCadCli.queryClientes.SQL.Add('');
            DmCadCli.queryClientes.SQL.Clear();
            DmCadCli.queryClientes.SQL.Add('UPDATE USUARIOS SET SEXO = :AltSexo');
            DmCadCli.queryClientes.SQL.Add('where ID ='+getId.ToString);

            DmCadCli.queryClientes.ParamByName('AltSexo').AsString := cmbSexo.Text;

            DmCadCli.queryClientes.ExecSQL;

            Application.MessageBox('Campo sexo atualizado com sucesso!','Altera��o!', MB_OK + MB_ICONINFORMATION);

            limparCampos;
            atualizaGrid();

            except
            begin
              Application.MessageBox('Opera��o n�o realizada verifique!','Altera��o!', MB_OK + MB_ICONINFORMATION);
            end;

            end;
        end;
    end;
end;


procedure TfrmCadUser.btnDeletarClick(Sender: TObject);
begin
    if (dbDados.Fields[0].AsInteger = 0) or (edtNome.Text = '')  then
    begin
      Application.MessageBox('Id n�o encontrado, ou n�o foi selecionado nenhum registro, verifique!','Altera��o!', MB_OK + MB_ICONINFORMATION);
    end
    else
    begin
      try

      var getId := dbDados.Fields[0].AsInteger;

      DmCadCli.queryClientes.SQL.Add('');
      DmCadCli.queryClientes.SQL.Clear();
      DmCadCli.queryClientes.SQL.Add('DELETE FROM USUARIOS');
      DmCadCli.queryClientes.SQL.Add('where ID ='+getId.ToString);

      DmCadCli.queryClientes.ExecSQL;

      Application.MessageBox('Registro deltado com sucesso!','Exclus�o!', MB_OK + MB_ICONINFORMATION);

      limparCampos;
      atualizaGrid();
      except
         begin
          Application.MessageBox('Opera��o n�o realizada verifique!','Altera��o!', MB_OK + MB_ICONINFORMATION);
        end;
      end;
    end;


end;

procedure TfrmCadUser.btnSairClick(Sender: TObject);
begin
     DmCadCli.queryClientes.Close;
     Application.Terminate;
end;

end.
