function tf = tr(value)
%TR Shorthand for truthy evaluation in MATLAB-Truthiness
%   tf = TR(value) returns true if value is considered truthy according to
%   the project's truthy rules. This is a concise alias for the TRUTHY function.

    tf = truthy(value);
end
