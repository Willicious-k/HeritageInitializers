
@attached(member, names: named(init))
public macro InitFromDict() = #externalMacro(
    module: "HeritageInitsMacros",
    type: "InitFromDict"
)
