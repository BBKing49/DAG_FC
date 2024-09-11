% PengXu. Jiangnan University. xupeng1724477385@gmail.com.

function has_NaN( input )

is_nan = double(isnan(input));
has_nan = ismember(1, is_nan);
if has_nan==1
    error('calculate results contains NaN!!!!!!!!!!!!');  
end

end

