function b = ismarker(m)
%ISMARKER Checks if structure m is a marker
%
%   Signature:          b = ismarker(marker)
%
%   Returns true on success, false otherwise.
%

fn = @(x) isfield(x, 'location') && ...
          isfield(x, 'color') && ...
          isfield(x, 'size') && ...
          isfield(x, 'label');

b = arrayfun(fn, m);      
      
end

