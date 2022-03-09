package cn.zwz.bill.utils;

import java.util.Date;

public class DateUtils {

    public static String getCompleteNowDate(){
        Date date = new Date();
        int year = date.getYear() + 1900;
        int month = date.getMonth() + 1;
        int date1 = date.getDate();
        return year + "-" + (month < 10 ? "0" + month : month) + "-" + (date1 < 10 ? "0" + date1 : date1);
    }
}
