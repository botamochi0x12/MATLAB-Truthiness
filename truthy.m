function out = truthy(varargin)
% truthy : Bind the value to either `Truthiness` or `Falsiness`.
%
% Actually, this function instantiates `LazyLogical` first. 
% After calling `LazyLogical::bind`, the value is bound to either 
% `Truthiness` or `Falsiness`.
%
% See Also: TRUTHINESS, FALSINESS, LAZYLOGICAL

    if nargin >= 2
        warning( ...
            "DeprecationWarning" ...
            + "call `resolveTruthinessChain`" ...
            + "if you want to use a legacy `truthy`.");
        error( ...
            "ArgumentError" ...
            + "The number of input arguments must be 1.");
    end
    if nargin == 1
        in = varargin{1};
        out = LazyLogical(in);
        return
    end
    if nargin == 0
        out = LazyLogical(true);
        return
    end
end
%%
