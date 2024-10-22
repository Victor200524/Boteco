package com.example.botecofx;

import com.example.botecofx.db.dals.GarcomDAL;
import com.example.botecofx.db.entidades.Garcom;
import javafx.collections.FXCollections;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Scene;
import javafx.scene.control.*;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.input.KeyEvent;
import javafx.stage.Modality;
import javafx.stage.Stage;

import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.ResourceBundle;

public class GarconConsultaController implements Initializable {
    public static Garcom garcom = null;

    @FXML
    private TableColumn<Garcom, String> col_Cidade;

    @FXML
    private TableColumn<Garcom, String> col_Fone;

    @FXML
    private TableColumn<Garcom, String> col_ID;

    @FXML
    private TableColumn<Garcom, String> col_Nome;

    @FXML
    private TableView<Garcom> tabela;

    @FXML
    private TextField tfFiltro;

    private GarcomDAL garconDAL;

    @FXML
    void onFechar(ActionEvent event) {
        tfFiltro.getScene().getWindow().hide();
    }

    @FXML
    void onFilter(KeyEvent event) {
        String filtro = tfFiltro.getText().toUpperCase();
        preencherTabela("upper(gar_nome) LIKE '"+filtro+"' ");
    }

    @FXML
    void onNovo(ActionEvent event) throws Exception{
        FXMLLoader fxmlLoader = new FXMLLoader(BotecoFX.class.getResource("garcon-form-view.fxml"));
        Scene scene = new Scene(fxmlLoader.load());
        Stage stage = new Stage();
        stage.setScene(scene);
        stage.initModality(Modality.APPLICATION_MODAL);
        stage.showAndWait();
        tfFiltro.setText("");
        preencherTabela("");
    }

    @Override
    public void initialize(URL url, ResourceBundle resourceBundle) {
        garconDAL = new GarcomDAL();
        col_ID.setCellValueFactory(new PropertyValueFactory<>("id"));
        col_Nome.setCellValueFactory(new PropertyValueFactory<>("nome"));
        col_Cidade.setCellValueFactory(new PropertyValueFactory<>("cidade"));
        col_Fone.setCellValueFactory(new PropertyValueFactory<>("fone"));
        preencherTabela("");
    }

    private void preencherTabela(String filtro) {
        List<Garcom> garconList = new ArrayList<>(); //garconDAL.get(filtro);
        garconList.add(new Garcom(1,"Zé","212121","19805330","","","Alvares Machado","SP",""));
        garconList.add(new Garcom(1,"Zé","212121","19805330","","","Alvares Machado","SP",""));
        tabela.setItems(FXCollections.observableArrayList(garconList));
    }

    @FXML
    void onExcluir(ActionEvent event) {
        if(tabela.getSelectionModel().getSelectedIndex() >= 0){
            Garcom garcom = tabela.getSelectionModel().getSelectedItem();
            Alert alert =new Alert(Alert.AlertType.CONFIRMATION);
            alert.setContentText("Deseja realmente excluir o garçom: " + garcom.getNome());
            alert.showAndWait();
            if(alert.showAndWait().get() == ButtonType.OK){
                garconDAL.apagar(garcom);
                onFilter(null);
            }
        }
    }

    public void onAlterar(ActionEvent actionEvent) throws Exception{
        if(tabela.getSelectionModel().getSelectedIndex()>=0){
            garcom = tabela.getSelectionModel().getSelectedItem();
            FXMLLoader fxmlLoader = new FXMLLoader(BotecoFX.class.getResource("garcon-form-view.fxml"));
            Scene scene = new Scene(fxmlLoader.load());
            Stage stage = new Stage();
            stage.setScene(scene);
            stage.initModality(Modality.APPLICATION_MODAL);
            stage.showAndWait();
            garcom=null;
            tfFiltro.setText("");
            preencherTabela("");
        }
    }
}
