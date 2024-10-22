package com.example.botecofx.db.dals;

import com.example.botecofx.db.entidades.Garcom;
import com.example.botecofx.db.util.IDAL;
import com.example.botecofx.db.util.SingletonDB;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class GarcomDAL implements IDAL<Garcom> {
    @Override
    public boolean gravar(Garcom entidade) {
        String sql = """
                    INSERT INTO garcon(
                    	gar_nome, gar_cpf, gar_cep, gar_endereco, gar_cidade, gar_uf, gar_fone, gar_foto, gar_numero)
                    	VALUES ('#1', '#2', '#3', '#4', '#5', '#6', '#7', '#8', '#9');
                """;
        // Correção: Substituindo corretamente os campos com os valores adequados
        sql = sql.replace("#1", entidade.getNome());
        sql = sql.replace("#2", entidade.getCpf());
        sql = sql.replace("#3", entidade.getCep());
        sql = sql.replace("#4", entidade.getEndereco());
        sql = sql.replace("#5", entidade.getCidade());
        sql = sql.replace("#6", entidade.getUf());
        sql = sql.replace("#7", entidade.getFone());
        //sql = sql.replace("#8", entidade.getFoto());  // Supondo que o campo foto exista
        sql = sql.replace("#9", entidade.getNumero());

        return SingletonDB.getConexao().manipular(sql);
    }

    @Override
    public boolean alterar(Garcom entidade) {
        String sql = """
                UPDATE garcon
                	SET gar_nome = '#1', gar_cpf = '#2', gar_cep = '#3', gar_endereco = '#4', gar_cidade = '#5', gar_uf = '#6', gar_fone = '#7', gar_foto = '#8', gar_numero = '#9'
                	WHERE gar_id = #10;
                """;
        // Correção: Substituindo os campos corretamente para o SQL de UPDATE
        sql = sql.replace("#1", entidade.getNome());
        sql = sql.replace("#2", entidade.getCpf());
        sql = sql.replace("#3", entidade.getCep());
        sql = sql.replace("#4", entidade.getEndereco());
        sql = sql.replace("#5", entidade.getCidade());
        sql = sql.replace("#6", entidade.getUf());
        sql = sql.replace("#7", entidade.getFone());
        //sql = sql.replace("#8", entidade.getFoto());  // Supondo que o campo foto exista
        sql = sql.replace("#9", entidade.getNumero());
        sql = sql.replace("#10", String.valueOf(entidade.getId()));

        return SingletonDB.getConexao().manipular(sql);
    }

    @Override
    public boolean apagar(Garcom entidade) {
        return SingletonDB.getConexao().manipular("DELETE FROM garcon WHERE gar_id = " + entidade.getId());
    }

    @Override
    public Garcom get(int id) {
        Garcom garcom = null;
        String sql = "SELECT * FROM garcon WHERE gar_id = " + id;
        ResultSet resultSet = SingletonDB.getConexao().consultar(sql);
        try {
            if (resultSet.next()) {
                garcom = new Garcom(id,
                        resultSet.getString("gar_nome"),
                        resultSet.getString("gar_cpf"),
                        resultSet.getString("gar_cep"),
                        resultSet.getString("gar_endereco"),
                        resultSet.getString("gar_numero"),
                        resultSet.getString("gar_cidade"),
                        resultSet.getString("gar_uf"),
                        resultSet.getString("gar_fone"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return garcom;
    }

    @Override
    public List<Garcom> get(String filtro) {
        List<Garcom> garcoms = new ArrayList<>();
        String sql = "SELECT * FROM garcon ";

        // Correção: Aplicação correta do filtro, se houver
        if (!filtro.isEmpty()) {
            sql += "WHERE " + filtro + " ";
        }
        sql += "ORDER BY gar_nome";

        ResultSet resultSet = SingletonDB.getConexao().consultar(sql);
        try {
            while (resultSet.next()) {
                garcoms.add(new Garcom(
                        resultSet.getInt("gar_id"),
                        resultSet.getString("gar_nome"),
                        resultSet.getString("gar_cpf"),
                        resultSet.getString("gar_cep"),
                        resultSet.getString("gar_endereco"),
                        resultSet.getString("gar_numero"),
                        resultSet.getString("gar_cidade"),
                        resultSet.getString("gar_uf"),
                        resultSet.getString("gar_fone")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return garcoms;
    }
}
