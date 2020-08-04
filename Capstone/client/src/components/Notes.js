import React, { useEffect, useContext, useState } from "react";
import { useParams } from "react-router-dom";
import { NoteContext } from "../providers/NoteProvider";
import Note from "./Note";
import { Button, Modal, ModalBody, Form, Label, Input, FormGroup } from "reactstrap";
import "../App.css";
import "./Notes.css";



const Notes = () => {

    const { id } = useParams();
    const { notes, getNotesByPoseId, addNote } = useContext(NoteContext);

    const [theNote, setTheNote] = useState();

    const [addNoteModal, setAddNoteModal] = useState(false);

    const toggleAdd = () => {
        setAddNoteModal(!addNoteModal);
    };

    const handleControlledInputChange = (event) => {
        setTheNote(event.target.value)
    };

    const constructNewNote = () => {
        addNote({
            poseId: parseInt(id),
            content: theNote,
            createDateTime: new Date()
        }).then(() => getNotesByPoseId(parseInt(id)))
    };

    useEffect(() => {
        getNotesByPoseId(parseInt(id));
    }, []);

    return (
        <>
            <div className="notes_container">
                <h2>Notes:</h2>
                <i className="fa fa-plus" onClick={toggleAdd}></i>
                {notes.map((note) =>
                    <Note key={note.id} note={note} />
                )}
            </div>

            <Modal isOpen={addNoteModal} toggle={toggleAdd}>
                <ModalBody>

                    <Form>
                        <FormGroup>
                            <Label for="exampleText">Make a note for yourself:</Label>
                            <Input
                                type="textarea"
                                name="text"
                                id="exampleText"
                                placeholder="Whats on your mind?"
                                onChange={handleControlledInputChange} />
                        </FormGroup>
                    </Form>
                    <Button
                        type="button"
                        className="btn btn-info addNoteButton"
                        onClick={() => {
                            constructNewNote();
                            setTheNote("");
                            toggleAdd();
                        }}
                    >Submit</Button>

                </ModalBody>
            </Modal>
        </>
    );
};
export default Notes;