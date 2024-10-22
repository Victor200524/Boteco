package com.example.botecofx.db.dals;

import com.example.botecofx.db.entidades.Comanda;
import com.example.botecofx.db.util.IDAL;
import com.example.botecofx.db.util.SingletonDB;

import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ComandaDAL implements IDAL<Comanda> {
    @Override
    public boolean gravar(Comanda entidade) {
        boolean erro = false;
        try {
            SingletonDB.getConexao().getConnect().setAutoCommit(false);
            String sql = """
                    INSERT INTO comanda(
                    	gar_id, com_numero, com_data, com_desc, com_valor, com_status)
                    	VALUES (#1, #2, '#3', '#4', #5, '#6');
                    """;
            sql = sql.replace("#1", "" + entidade.getGarcon().getId());
            sql = sql.replace("#2", "" + entidade.getNumero());
            sql = sql.replace("#3", "" + entidade.getData());
            sql = sql.replace("#4", entidade.getDescricao());
            sql = sql.replace("#5", ""+entidade.getValor());
            sql = sql.replace("#6", "" + entidade.getStatus());
            if (SingletonDB.getConexao().manipular(sql)) {
                int id = SingletonDB.getConexao().getMaxPK("comanda", "com_id");
                //gravar os Itens
                for (Comanda.Item item : entidade.getItens()) {
                    sql = """
                            INSERT INTO item(
                            	  com_id, prod_id, it_quantidade, it_valor)
                            	VALUES (#1, #2, #3, #4);
                            """;
                    sql = sql.replace("#1", "" + id);
                    sql = sql.replace("#2", "" + item.produto().getId());
                    sql = sql.replace("#3", "" + item.quant());
                    sql = sql.replace("#4", "" + item.produto().getPreco());

                    if (!SingletonDB.getConexao().manipular(sql))
                        erro = true;
                }
            } else
                erro = true;
            if(!erro){
                SingletonDB.getConexao().getConnect().commit();
            }
            else{
                SingletonDB.getConexao().getConnect().rollback();
            }
            SingletonDB.getConexao().getConnect().setAutoCommit(true);
        }
        catch (Exception e){ e.printStackTrace();}
        return erro;
    }

    @Override
    public boolean alterar(Comanda entidade) {
        boolean erro = false;
        try {
            SingletonDB.getConexao().getConnect().setAutoCommit(false);
            String sql = """
                    UPDATE comanda
                    	SET gar_id=#1, com_numero=#2, com_data='#3', com_desc='#4', com_valor=#5, com_status='#6'
                    	WHERE com_id=#7;
                    """;
            sql = sql.replace("#1", "" + entidade.getGarcon().getId());
            sql = sql.replace("#2", "" + entidade.getNumero());
            sql = sql.replace("#3", "" + entidade.getData());
            sql = sql.replace("#4", entidade.getDescricao());
            sql = sql.replace("#5", ""+entidade.getValor());
            sql = sql.replace("#6", "" + entidade.getStatus());
            sql = sql.replace("#7", "" + entidade.getId());

            if (SingletonDB.getConexao().manipular(sql)) {
                //apagar os Itens
                if(SingletonDB.getConexao().manipular("DELETE FROM item WHERE com_id="+entidade.getId()))
                    erro=true;
                for (Comanda.Item item : entidade.getItens()) {
                    sql = """
                            INSERT INTO item(
                            	  com_id, prod_id, it_quantidade, it_valor)
                            	VALUES (#1, #2, #3, #4);
                            """;
                    sql = sql.replace("#1", "" + entidade.getId());
                    sql = sql.replace("#2", "" + item.produto().getId());
                    sql = sql.replace("#3", "" + item.quant());
                    sql = sql.replace("#4", "" + item.produto().getPreco());

                    if (!SingletonDB.getConexao().manipular(sql))
                        erro = true;
                }
            } else
                erro = true;
            if(!erro){
                SingletonDB.getConexao().getConnect().commit();
            }
            else{
                SingletonDB.getConexao().getConnect().rollback();
            }
            SingletonDB.getConexao().getConnect().setAutoCommit(true);
        }
        catch (Exception e){ e.printStackTrace();}
        return erro;
    }

    @Override
    public boolean apagar(Comanda entidade) {
        boolean ok=false;
        if(SingletonDB.getConexao().manipular("DELETE FROM item WHERE com_id="+entidade.getId()))
        {
            if(SingletonDB.getConexao().manipular("DELETE FROM comanda WHERE com_id="+entidade.getId()))
                ok=true;
        }
        return ok;
    }

    @Override
    public Comanda get(int id) {
        Comanda comanda=null;
        String sql="SELECT * FROM comanda WHERE com_id="+id;
        ResultSet rs=SingletonDB.getConexao().consultar(sql);
        try {
            if (rs.next()) {
                comanda = new Comanda(rs.getInt("com_id"), rs.getInt("com_numero"),
                        rs.getString("com_desc"), rs.getDate("com_data").toLocalDate(),
                        rs.getDouble("com_valor"), rs.getString("com_status").charAt(0),
                        new GarconDAL().get(rs.getInt("gar_id")));
                sql="SELECT * FROM item WHERE com_id="+id;
                ResultSet rs2=SingletonDB.getConexao().consultar(sql);
                while(rs2.next())
                {
                    Comanda.Item item=new Comanda.Item(new ProdutoDAL().get(rs2.getInt("prod_id")),
                            rs2.getInt("it_quantidade"),rs2.getDouble("it_valor"));
                    comanda.addItem(item);
                }
            }
        }catch (Exception e){e.printStackTrace();}
        return comanda;
    }

    @Override
    public List<Comanda> get(String filtro) {
        List<Comanda> comandas=new ArrayList<>();
        String sql="SELECT * FROM comanda";
        if(!filtro.isEmpty())
           sql+=" WHERE "+filtro;
        ResultSet rs=SingletonDB.getConexao().consultar(sql);
        try {
            while (rs.next()) {
                Comanda comanda = new Comanda(rs.getInt("com_id"), rs.getInt("com_numero"),
                        rs.getString("com_desc"), rs.getDate("com_data").toLocalDate(),
                        rs.getDouble("com_valor"), rs.getString("com_status").charAt(0),
                        new GarconDAL().get(rs.getInt("gar_id")));
                sql="SELECT * FROM item WHERE com_id="+comanda.getId();
                ResultSet rs2=SingletonDB.getConexao().consultar(sql);
                while(rs2.next())
                {
                    Comanda.Item item=new Comanda.Item(new ProdutoDAL().get(rs2.getInt("prod_id")),
                            rs2.getInt("it_quantidade"),rs2.getDouble("it_valor"));
                    comanda.addItem(item);
                }
                comandas.add(comanda);
            }
        }catch (Exception e){e.printStackTrace();}
        return comandas;
    }
}
