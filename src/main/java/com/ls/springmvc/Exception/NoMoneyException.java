package com.ls.springmvc.Exception;

public class NoMoneyException extends RuntimeException{
    public NoMoneyException(String message) {
        super(message);
    }
    public static void main(String[] args) throws NoMoneyException {
        throw new NoMoneyException("KFC Crazy Thursday whoever gives me $50, I will thank him.");
    }
}

