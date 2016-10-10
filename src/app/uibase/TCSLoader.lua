--
-- 封装CSLoader
-- Date: 2016-10-08 16:37:08
--
local TCSLoader = {}

function TCSLoader:loadCSB(resourceFilename,target)
	print("resourceFilename",resourceFilename)
	local node = cc.CSLoader:createNode(resourceFilename)
	if node then 
		TCSLoader:putChildrenToTarget(node, target)
		target.ccsNodeNameArr = {}
	end 
	return node
end

----------------------------------
-- 将所有的子成员都赋值到父节点中 父节点可以直接调用self[nodeName]
----------------------------------
function TCSLoader:putChildrenToTarget(node,target)
	local children = node:getChildren()
	for i,v in ipairs(children) do
		self:putChildrenToTarget(v,target)
		local name = v:getName()
		target["ccs"..name] = v
	end
end

return TCSLoader