function b = ispath(p)
%ISPATH Checks if structure p is a path
%
%   Signature:          b = ispath(p)
%
%   Returns true on success, false otherwise.
%

fn = @(x) isfield(x, 'locations') && ...
          isfield(x, 'weight') && ...
          isfield(x, 'color') && ...
          isfield(x, 'fillcolor');

b = arrayfun(fn,p);      

end

