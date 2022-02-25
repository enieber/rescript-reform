

module FormFields = %lenses(
  type state = {
    title: string,
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
      title: "",
      ingredients: "",
      instructions: "",
    },
    ~schema={
      open UserForm.Validation

      Schema(
        nonEmpty(~error="Title is required", Title) +
        string(~min=3, Title) +
        custom(state => state.title == state.ingredients ? Error("Title not be equal igredient"): Valid, Title) + 
        custom(state => state.title == state.ingredients ? Error("Ingredients not be equal titles"): Valid, Ingredients) + 
        nonEmpty(~error="Ingredients is required", Ingredients) +
        string(~min=3, Ingredients) +
        nonEmpty(~error="Instructionns is required", Instructions) +
        string(~min=3, Instructions),
      )
    },
    (),
  )
  let errorInTitle = switch form.getFieldError(Field(Title)) {
    | Some(s) => s
    | None => ""
  }
  let errorInInstructions = switch form.getFieldError(Field(Instructions)) {
    | Some(s) => s
    | None => ""
  }
  let errorInIngredients = switch form.getFieldError(Field(Ingredients)) {
    | Some(s) => s
    | None => ""
  }

let isDisabled = Belt.Option.isSome(form.getFieldError(Field(Title))) || 
Belt.Option.isSome(form.getFieldError(Field(Instructions))) || 
Belt.Option.isSome(form.getFieldError(Field(Ingredients)))

  let isDisabledSubmit = isDisabled

  <form
    onSubmit={event => {
      ReactEvent.Synthetic.preventDefault(event)
      dispatch(Store.AddRecipe({
        title: form.values.title,
        ingredients: form.values.ingredients,
        instructions: form.values.instructions
      }))
      RescriptReactRouter.push(`/recipes/${form.values.title}`)
      form.submit()
    }}
    className=CardStyles.formCard
    >
    <div>
      <input
        placeholder="Title"
        value={form.values.title}
        onChange={ReForm.Helpers.handleChange(form.handleChange(FormFields.Title))}
      />
        <h4> {React.string(errorInTitle)} </h4>
    </div>
    <div>
      <label>
        <h3> {React.string("Ingredients")} </h3>
        <textarea
          onChange={ReForm.Helpers.handleChange(form.handleChange(FormFields.Ingredients))}
          value={form.values.ingredients}
        />
        <h4> {React.string(errorInIngredients)} </h4>
      </label>
    </div>
    <div>
      <label>
        <h3> {React.string("Instructions")} </h3>
        <textarea
          onChange={ReForm.Helpers.handleChange(form.handleChange(FormFields.Instructions))}
          value={form.values.instructions}
        />
        <h4> {React.string(errorInInstructions)} </h4>
      </label>
    </div>
    <button className="button" type_="submit" disabled={isDisabledSubmit}>
      {React.string("Adicionar")}
    </button>
  </form>
}
