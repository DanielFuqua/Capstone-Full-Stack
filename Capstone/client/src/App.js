import React from 'react';
import logo from './logo.svg';
import { BrowserRouter as Router } from "react-router-dom";
import { UserProfileProvider } from "./providers/UserProfileProvider";
import ApplicationViews from "./components/ApplicationViews";
import { PoseProvider } from './providers/PoseProvider';
import { InstructionProvider } from './providers/InstructionProvider';
import { BenefitProvider } from './providers/BenefitProvider';
import { NoteProvider } from './providers/NoteProvider';
import { CommentProvider } from './providers/CommentProvider';


function App() {
  return (
    <Router>
      <UserProfileProvider>
        <PoseProvider>
          <InstructionProvider>
            <BenefitProvider>
              <NoteProvider>
                <CommentProvider>
                  <ApplicationViews />
                </CommentProvider>
              </NoteProvider>
            </BenefitProvider>
          </InstructionProvider>
        </PoseProvider>
      </UserProfileProvider>
    </Router>
  );
}

export default App;
