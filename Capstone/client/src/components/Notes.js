import React, { useEffect, useContext, useState } from "react";
import { useParams } from "react-router-dom";
import { NoteContext } from "../providers/NoteProvider";
import { CardTitle, Card, CardText, Button } from "reactstrap";

const Notes = () => {

    const { id } = useParams();
    const { notes, getNotesByPoseId } = useContext(NoteContext);


    useEffect(() => {
        getNotesByPoseId(parseInt(id));
    }, []);


    return (
    
                <div className="notes_container">
                    <h2>Notes:</h2>
                    {notes.map((note) => 
                    <Card body>
                    <CardTitle>{new Date(note.createDateTime).toLocaleDateString('en-us')}</CardTitle>
                    <CardText>{note.content}</CardText>
                    <Button>Delete</Button>
                  </Card>
                  )}
                </div>

             

    );
};
export default Notes;