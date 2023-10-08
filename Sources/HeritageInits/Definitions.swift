
@attached(member, names: named(init))
public macro InitFromDict() = #externalMacro(
    module: "HeritageInitsMacros",
    type: "InitFromDictMacro"
)

@attached(member, names: named(init))
public macro InitFromJSONString() = #externalMacro(
    module: "HeritageInitsMacros",
    type: "InitFromJSONStringMacro"
)
