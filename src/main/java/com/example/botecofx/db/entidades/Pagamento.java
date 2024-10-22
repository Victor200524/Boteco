package com.example.botecofx.db.entidades;

public class Pagamento {
    private int id;
    private double valor;
    private TipoPagamento tipoPagamento;

    public Pagamento(int id, double valor, TipoPagamento tipoPagamento) {
        this.id = id;
        this.valor = valor;
        this.tipoPagamento = tipoPagamento;
    }

    public Pagamento(double valor, TipoPagamento tipoPagamento) {
        this(0,valor,tipoPagamento);
    }

    public Pagamento() {
        this(0,0,null);
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public double getValor() {
        return valor;
    }

    public void setValor(double valor) {
        this.valor = valor;
    }

    public TipoPagamento getTipoPagamento() {
        return tipoPagamento;
    }

    public void setTipoPagamento(TipoPagamento tipoPagamento) {
        this.tipoPagamento = tipoPagamento;
    }
}
