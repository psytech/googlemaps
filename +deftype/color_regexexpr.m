function y = color_regexexpr(transparency)
%COLOR_REGEXEXPR Returns a regular expression to validate colors 
%   Validatation of colors in hexadecimal format with prefix 0x.
%   
%   Signature:              expr = color_regexexpr(transparency)
%
%   With transparency = true all colors with 8 characters are matched, else
%   only six characters are allowed.

N = [];

if nargin < 1 || ~transparency 
    N = 6;
elseif transparency 
    N = 8;
else
    error('Invalid argument');
end

y = sprintf('^(0x)([a-f]|[A-F]|[0-9]){%i}?$', N);

end

