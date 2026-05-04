package org.FlyingSparrow.YiSmartCloud.serve.util;

import java.time.LocalDate;
import java.time.Period;
import java.util.Optional;

import org.FlyingSparrow.YiSmartCloud.common.utils.StringUtils;

/**
 * 18 位大陆身份证号解析（出生日期、性别、年龄）。
 */
public final class IdCardParseUtil {

    private IdCardParseUtil() {
    }

    public static Optional<LocalDate> birthDateFrom18(String idCardNo) {
        if (StringUtils.isEmpty(idCardNo)) {
            return Optional.empty();
        }
        String digits = idCardNo.trim().replaceAll("\\s+", "");
        if (digits.length() != 18) {
            return Optional.empty();
        }
        String ymd = digits.substring(6, 14);
        for (int i = 0; i < ymd.length(); i++) {
            if (!Character.isDigit(ymd.charAt(i))) {
                return Optional.empty();
            }
        }
        try {
            int y = Integer.parseInt(ymd.substring(0, 4));
            int m = Integer.parseInt(ymd.substring(4, 6));
            int d = Integer.parseInt(ymd.substring(6, 8));
            return Optional.of(LocalDate.of(y, m, d));
        } catch (Exception e) {
            return Optional.empty();
        }
    }

    /**
     * 性别：0 男，1 女（与项目 elder 字段约定一致）。
     */
    public static Optional<Integer> genderFrom18(String idCardNo) {
        if (StringUtils.isEmpty(idCardNo)) {
            return Optional.empty();
        }
        String digits = idCardNo.trim().replaceAll("\\s+", "");
        if (digits.length() != 18) {
            return Optional.empty();
        }
        char c = digits.charAt(16);
        if (!Character.isDigit(c)) {
            return Optional.empty();
        }
        int n = Character.getNumericValue(c);
        return Optional.of((n & 1) == 1 ? 0 : 1);
    }

    public static Optional<Integer> ageFrom18(String idCardNo) {
        return birthDateFrom18(idCardNo).map(b -> Period.between(b, LocalDate.now()).getYears());
    }
}
