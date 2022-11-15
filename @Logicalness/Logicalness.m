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
        
        % not : Perform the logical operation `not` to the value.
        %
        % See Also: NOT 
        not(self)
        
        % and : Perform the logical operation `and` between the `self`'s value and the passed value.
        % 
        % See Also: AND
        and(self, other)
        
        % or : Perform the logical operation `or` between the `self`'s value and the passed value.
        % 
        % See Also: OR
        or(self, other)
        
        % xor : Perform the logical operation `xor` between the `self`'s value and the passed value.
        % 
        % See Also: XOR
        xor(self, other)
        
        % andThen : Perform the logical operation `and` to the `self`'s value and then apply the passed function.
        % 
        % See Also: AND
        andThen(self, other)
        
        % orElse : Perform the logical operation `or` to the `self`'s value or else apply the passed function.
        % 
        % See Also: OR
        orElse(self, other)
        
        % unwrap : Unwrap the value of the instance of `self`.
        unwrap(self)
        
        % logical : Evaluate the value as either `true` or `false`.
        % 
        % See Also: LOGICAL
        logical(self)
    end
end

