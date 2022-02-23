module Styles = {
  open CssJs
  let longEntry = style(. [
    width(100.0->#percent),
    maxWidth(20.0->#rem),
    borderRadius(0.5->#rem),
    padding(0.5->#rem),
  ])
}

module FormFields = %lenses(
  type state = {
    tile: string,
    ingredients: string,
    instructions: string,
  }
)

module UserForm = ReForm.Make(FormFields)

@react.component
let make = (~dispatch: Store.action => unit) => {
   let form: UserForm.api = UserForm.use(
    ~validationStrategy=OnChange,
    ~onSubmit={(state) => {
      Js.log(state)

      None
    }},
    ~initialState={
      tile: "",
      ingredients: "",
      instructions: "",
    },
    ~schema={
      open UserForm.Validation

      Schema(
        nonEmpty(~error="Title is required", Title) +
        string(~min=3, Title) +
        nonEmpty(~error="Ingredients is required", Ingredients) +
        string(~min=3, Ingredients) +
        nonEmpty(~error="Instructionns is required", Instructionns) +
        string(~min=3, Instructionns),
      )
    },
    (),
  )

  <form
    onSubmit={event => {
      ReactEvent.Synthetic.preventDefault(event)
      dispatch(Store.AddRecipe({
        title: form.values.title,
        ingredients: form.values.ingredients,
        instructions: form.values.instructions
      }))
      form.submit()
    }}
    className=CardStyles.formCard
    >
    <div>
      <input
        className=Styles.longEntry
        placeholder="Title"
        value={form.values.title}
        onChange={ReForm.Helpers.handleChange(form.handleChange(FormFields.Title))}
      />
    </div>
    <div>
      <label>
        <h3> {React.string("Ingredients")} </h3>
        <textarea
          className=Styles.longEntry
          onChange={ReForm.Helpers.handleChange(form.handleChange(FormFields.Ingredients))}
          value={form.values.ingredients}
        />
      </label>
    </div>
    <div>
      <label>
        <h3> {React.string("Instructions")} </h3>
        <textarea
          className=Styles.longEntry
          onChange={ReForm.Helpers.handleChange(form.handleChange(FormFields.Instructions))}
          value={form.values.instructions}
        />
      </label>
    </div>
    <button className="button" type_="submit" disabled={form.formState === Submitting}>
      {React.string("Adicionar")}
    </button>
  </form>
}
