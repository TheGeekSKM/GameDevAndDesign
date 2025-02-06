/// @desc Will loop any given num between min and max. If the num goes above max, it will loop the num back to min and vice versa.
/// @param {real} num number to loop
/// @param {real} minInclusive smallest number that num can be
/// @param {real} maxInclusive largest number that num can be
/// @return {real} returns the adjusted num
function loop(num, minInclusive, maxInclusive){
    if (num > maxInclusive)  num = minInclusive;
    else if (num < minInclusive) num = maxInclusive;
        
    return num;
}