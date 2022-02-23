
@send external focus: Dom.element => unit = "focus"

module FormFields = %lenses(
  type state = {
    tag: string,
  }
)

module UserForm = ReForm.Make(FormFields)

@react.component
let make = (~recipeTitle: string, ~dispatch: Store.action => unit) => {
  let inputTag = React.useRef(Js.Nullable.null);
  let form: UserForm.api = UserForm.use(
    ~validationStrategy=OnChange,
    ~onSubmit={(state) => {
      Js.log(state)

      None
    }},
    ~initialState={
      tag: "",
    },
    ~schema={
      open UserForm.Validation
      Schema(nonEmpty(Tag))
    },
    (),
  )


<form
    onSubmit={event => {
      ReactEvent.Synthetic.preventDefault(event)
       switch inputTag.current->Js.Nullable.toOption {
          | Some(dom) => dom->focus
          | None => ()
        }
      dispatch(Store.AddTag({recipeTitle: recipeTitle, tag: form.values.tag}))
      form.submit()
      form.resetForm();
    }}>
    <div>
      <label> {React.string("Tag")} </label>
      <input
      ref={ReactDOM.Ref.domRef(inputTag)}
      placeholder="Add tag..."
      value={form.values.tag}
      onChange={ReForm.Helpers.handleChange(form.handleChange(FormFields.Tag))}
      type_="text"
    />
        </div>
    <button className="button" type_="submit" disabled={form.formState === Submitting}>
      {React.string("Adicionar")}
    </button>
  </form>
}
