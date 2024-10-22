package com.example.botecofx.db.entidades;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class Comanda {
    public static record Item(Produto produto, int quant, double valor){};
    private int id;
    private int numero;
    private String descricao;
    private LocalDate data;
    private double valor;
    private char status;// A:aberta F:fechada C:cancelada
    private Garcon garcon;
    private List<Pagamento> pagamentos;
    private List<Item> itens;

    public Comanda(int id, int numero, String descricao, LocalDate data, double valor, char status, Garcon garcon) {
        this.id = id;
        this.numero = numero;
        this.descricao = descricao;
        this.data = data;
        this.valor = valor;
        this.status = status;
        this.garcon = garcon;
        pagamentos=new ArrayList<>();
        itens=new ArrayList<>();
    }

    public Comanda(int numero, String descricao, LocalDate data, double valor, char status, Garcon garcon) {
        this(0,numero,descricao,data,valor,status,garcon);
    }

    public Comanda() {
        this(0,0,"",LocalDate.now(),0,'A',null);
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getNumero() {
        return numero;
    }

    public void setNumero(int numero) {
        this.numero = numero;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public LocalDate getData() {
        return data;
    }

    public void setData(LocalDate data) {
        this.data = data;
    }

    public double getValor() {
        return valor;
    }

    public void setValor(double valor) {
        this.valor = valor;
    }

    public char getStatus() {
        return status;
    }

    public void setStatus(char status) {
        this.status = status;
    }

    public Garcon getGarcon() {
        return garcon;
    }

    public void setGarcon(Garcon garcon) {
        this.garcon = garcon;
    }

    public List<Pagamento> getPagamentos() {
        return pagamentos;
    }

    public List<Item> getItens() {
        return itens;
    }
    public boolean addPagamento(TipoPagamento tpagamento, double valor)
    {
        return pagamentos.add(new Pagamento(valor,tpagamento));
    }
    public boolean addItem(Item item)
    {
       return itens.add(item);
    }
}
