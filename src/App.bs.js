// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Curry from "bs-platform/lib/es6/curry.mjs";
import * as React from "react";
import * as RescriptReactRouter from "@rescript/react/src/RescriptReactRouter.bs.js";
import * as Store$RescriptReactIntro from "./Store.bs.js";
import * as NavBar$RescriptReactIntro from "./NavBar.bs.js";
import * as AllTags$RescriptReactIntro from "./AllTags.bs.js";
import * as ViewRecipe$RescriptReactIntro from "./ViewRecipe.bs.js";
import * as AddRecipeForm$RescriptReactIntro from "./AddRecipeForm.bs.js";

function App(Props) {
  var url = RescriptReactRouter.useUrl(undefined, undefined);
  var match = React.useReducer(Store$RescriptReactIntro.reducer, Store$RescriptReactIntro.initialState);
  var dispatch = match[1];
  var state = match[0];
  React.useEffect((function () {
          Curry._1(dispatch, {
                TAG: /* AddRecipe */0,
                title: "Bread",
                ingredients: "flour, salt, water, yeast",
                instructions: "Mix, let rise overnight, bake at 400"
              });
          Curry._1(dispatch, {
                TAG: /* AddTag */1,
                recipeTitle: "Bread",
                tag: "carbs"
              });
          
        }), [dispatch]);
  var match$1 = url.path;
  var component;
  var exit = 0;
  if (match$1) {
    switch (match$1.hd) {
      case "recipes" :
          var match$2 = match$1.tl;
          if (match$2) {
            var title = match$2.hd;
            if (title === "add") {
              if (match$2.tl) {
                exit = 1;
              } else {
                component = React.createElement(AddRecipeForm$RescriptReactIntro.make, {
                      dispatch: dispatch
                    });
              }
            } else if (match$2.tl) {
              exit = 1;
            } else {
              component = React.createElement("div", undefined, React.createElement(ViewRecipe$RescriptReactIntro.make, {
                        state: state,
                        title: title
                      }));
            }
          } else {
            exit = 1;
          }
          break;
      case "tags" :
          if (match$1.tl) {
            exit = 1;
          } else {
            component = React.createElement(AllTags$RescriptReactIntro.make, {
                  tags: state.tags
                });
          }
          break;
      default:
        exit = 1;
    }
  } else {
    component = React.createElement("div", undefined, "Home page");
  }
  if (exit === 1) {
    component = React.createElement("div", undefined, "Route not found");
  }
  return React.createElement("div", undefined, React.createElement(NavBar$RescriptReactIntro.make, {}), component);
}

var make = App;

export {
  make ,
  
}
/* react Not a pure module */
