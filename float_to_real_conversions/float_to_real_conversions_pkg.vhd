library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;
    use ieee.math_real.all;

    use work.float_type_definitions_pkg.all;

package float_to_real_conversions_pkg is
------------------------------------------------------------------------
    function to_float ( real_number : real)
        return float_record;
------------------------------------------------------------------------
    function get_mantissa ( number : real)
        return unsigned;
------------------------------------------------------------------------
    function get_exponent ( number : real)
        return t_exponent;
------------------------------------------------------------------------
    function to_real ( float_number : float_record)
        return real;
------------------------------------------------------------------------
    function get_exponent ( number : real)
        return real;

end package float_to_real_conversions_pkg;

package body float_to_real_conversions_pkg is

------------------------------------------------------------------------
    function get_exponent
    (
        number : real
    )
    return real
    is
    begin
        if number = 0.0 then
            return 0.0;
        else
            return floor(log2(abs(number)))+1.0;
        end if;
    end get_exponent;
------------------------------------------------------------------------
    function get_mantissa
    (
        number : real
    )
    return real
    is
    begin
        return (abs(number)/2**get_exponent(number));
    end get_mantissa;
------------------------------------------------------------------------

------------------------------------------------------------------------
    function get_mantissa
    (
        number : real
    )
    return unsigned
    is
    begin
        return to_unsigned(integer(get_mantissa(number) * 2.0**mantissa_length), mantissa_length);
    end get_mantissa;
------------------------------------------------------------------------
    function get_exponent
    (
        number : real
    )
    return t_exponent
    is
        variable result : real := 0.0;
    begin
        result := get_exponent(number);
        return to_signed(integer(result),exponent_length);
    end get_exponent;
------------------------------------------------------------------------
    function get_sign
    (
        number : real
    )
    return signed
    is
        variable result : signed(0 downto 0);
    begin

        if number >= 0.0 then
            result := "0";
        else
            result := "1";
        end if;

        return result;
        
    end get_sign;
------------------------------------------------------------------------
    function get_data
    (
        int_number : integer;
        real_number : real
    )
    return signed 
    is
        variable returned_signed : t_exponent;
    begin
        if real_number >= 0.0 then 
            returned_signed := to_signed(int_number, exponent_length);
        else
            returned_signed := -to_signed(int_number, exponent_length);
        end if;

        return returned_signed;

    end get_data;
------------------------------------------------------------------------
    function to_float
    (
        real_number : real
    )
    return float_record
    is
        variable returned_float : float_record := ("0", (others => '0'), (others => '0'));

    begin

        returned_float.sign     := get_sign(real_number);
        returned_float.exponent := get_exponent(real_number);
        returned_float.mantissa := get_mantissa(real_number);

        return returned_float;
        
    end to_float;
------------------------------------------------------------------------
    function to_real
    (
        float_number : float_record
    )
    return real
    is
        variable result : real := 1.0;
    begin

        result := (2.0**real(to_integer(float_number.exponent))) * real(to_integer(float_number.mantissa))/2.0**(mantissa_length);
        return result;
        
    end to_real;
------------------------------------------------------------------------
end package body float_to_real_conversions_pkg;
