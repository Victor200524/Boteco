package com.example.botecofx;

import com.example.botecofx.db.dals.GarcomDAL;
import com.example.botecofx.db.entidades.Garcom;
import com.example.botecofx.db.util.SingletonDB;
import com.example.botecofx.util.APIservices;
import com.example.botecofx.util.MaskFieldUtil;
import javafx.application.Platform;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import
import javafx.scene.control.Alert;
import javafx.scene.control.TextField;
import javafx.scene.input.KeyEvent;

import java.net.URL;
import java.util.ResourceBundle;

public class GarconFormController implements Initializable {
    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        Platform.runLater(new Runnable() { //Nao vai permitir nomes
            @Override
            public void run() {
                tfNOME.requestFocus();
            }
        });
        MaskFieldUtil.cpfField(tfCPF);
        MaskFieldUtil.cepField(tfCEP);
        MaskFieldUtil.foneField(tfTELEFONE);
        //se for alteração, preenche os dados
        if(GarconConsultaController.garcom!=null){
            Garcom aux = GarconConsultaController.garcom;
            tfNOME.setText(aux.getNome());
        }
    }

    @FXML
    private TextField tfCEP;

    @FXML
    private TextField tfCIDADE;

    @FXML
    private TextField tfCPF;

    @FXML
    private TextField tfENDERECO;

    @FXML
    private TextField tfID;

    @FXML
    private TextField tfNOME;

    @FXML
    private TextField tfNUMERO;

    @FXML
    private TextField tfTELEFONE;

    @FXML
    private TextField tfUF;

    @FXML
    void btnCancelar(ActionEvent event) {

    }

    @FXML
    void btnConfirma(ActionEvent event) {
        Garcom garcom = new Garcom(tfID.getId(),tfNOME.getText(),tfCPF.getText(),tfENDERECO.getText(),
                tfNUMERO.getText(),tfCIDADE.getText(),tfUF.getText(),tfTELEFONE.getText());
        if(!new GarcomDAL().gravar(garcom)){
            Alert alert = new Alert(Alert.AlertType.ERROR);
            alert.setContentText("Erro ao gravar o garçom " + SingletonDB.getConexao().getMensagemErro());
            alert.showAndWait();
        }
        btnConfirma.;
    }

    public void onBuscarCEP(KeyEvent keyEvent) {
        if(tfCEP.getText().length() == 9){
            APIservices.consultaCep(tfCEP.getText(),"json");
            JSONObject json = new JSONObjetct(dados);
            tfCIDADE.setText(json.getString("localidade"));
            tfENDERECO.setText(json.getString("endereco"));
            tfUF.setText(json.getString("uf"));
        }
    }
}