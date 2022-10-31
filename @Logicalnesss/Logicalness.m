classdef (Abstract) Logicalness < handle
    methods(Access = public, Static)
        function clsName = selfClassName()
            clsName = mfilename('class');
        end
        function retval = isLogicalness(val)
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

