defmodule Cellar.Entry do
  defstruct company: "",
            bottler: nil,
            name: "",
            style: "",
            vintage: nil,
            purchase_date: nil,
            size: nil,
            quantity: 0,
            box_number: nil,
            type: nil

  @type t :: %__MODULE__{
          company: String.t(),
          bottler: String.t(),
          name: String.t(),
          style: String.t(),
          vintage: String.t(),
          purchase_date: String.t(),
          size: 0,
          quantity: 0,
          box_number: 0,
          type: String.t()
        }
end
