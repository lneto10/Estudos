package model.exceptions;

public class BusinessException extends RuntimeException{

    private static final long SerialVersion = 1L;

    public BusinessException(String msg){
        super(msg);
    }

}
