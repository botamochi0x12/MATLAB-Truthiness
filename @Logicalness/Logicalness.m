classdef (Abstract) Logicalness < handle
% Logicalness : The base class for `LazyLogical`, `Truthiness`, `Falsiness` and so on.
% 
% This is the base class for some sub-classes containing only one lazily evaluatable value.
% The sub-classes MUST have the methods such as `not`, `and`, `or`, `andThen`, `orElse`, `unwrap` and `logical`.
% 
% See Also: LAZYLOGICAL, TRUTHINESS, FALSINESS

    methods(Access = public, Static)
        function clsName = selfClassName()
        % selfClassName : The class name of the instance.
            clsName = mfilename('class');
        end
        function retval = isLogicalness(val)
        % isLogicalness : Check if the parameter `val` is an instance of `Logialness`.
            retval = isa(val, 'Logicalness');
        end
    end
    methods (Abstract)
        % NOTE: The method `Logicalness(val)` doesn't need to define.
        not(self)
        and(self, other)
        or(self, other)
        xor(self, other)
        andThen(self, other)
        orElse(self, other)
        unwrap(self)
        logical(self)
    end
end

