[DefaultOutputDestinationSettings = [DestinationDefinition = [Kind = "Reference", QueryName = "DefaultDestination", IsNewTarget = true], UpdateMethod = [Kind = "Replace"], DestinationTypeSettings = [Kind = "Table"]], StagingDefinition = [Kind = "FastCopy"]]
section Section1;
shared DefaultDestination = Lakehouse.Contents([EnableFolding = false]){[workspaceId = "c4f9674e-cc5b-4d2b-a618-160afb7ab4d2"]}[Data]{[lakehouseId = "a9fc6823-fa0a-43ea-8271-6b55bec2f492"]}[Data];
[BindToDefaultDestination = true]
shared dimension_customer = let
  Source = Csv.Document(Web.Contents("https://thebakingroomnet-my.sharepoint.com/personal/eric_thebakingroom_net/Documents/Fabric%20Tutorial/dimension_customer.csv"), [Delimiter = ",", Columns = 11, Encoding = 65001, QuoteStyle = QuoteStyle.None]),
  #"Promoted headers" = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
  #"Changed column type" = Table.TransformColumnTypes(#"Promoted headers", {{"CustomerKey", Int64.Type}, {"WWICustomerID", Int64.Type}, {"Customer", type text}, {"BillToCustomer", type text}, {"Category", type text}, {"BuyingGroup", type text}, {"PrimaryContact", type text}, {"PostalCode", type text}, {"ValidFrom", type datetime}, {"ValidTo", type datetime}, {"LineageKey", Int64.Type}}),
  #"Changed column type 1" = Table.TransformColumnTypes(#"Changed column type", {{"ValidTo", type date}})
in
  #"Changed column type 1";
