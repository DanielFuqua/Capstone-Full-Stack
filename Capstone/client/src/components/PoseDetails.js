import React, { useEffect, useContext, useState} from "react";
import { Button, Modal, ModalBody } from "reactstrap"
import { useParams, Link } from "react-router-dom";
import { PoseContext } from "../providers/PoseProvider";



const PoseDetails = () => {
    
  const { id } = useParams();
  const history = useHistory();
  const [pose, setPose] = useState();
  const { getPoseById } = useContext(PoseContext);


useEffect(() => {
    getPoseById(id).then((pose) => {
        setPose(pose);
    });
}, []);


  return (
<>
    <div>
        <p>{pose.nameEnglish}</p>
        <p>{pose.nameSanskrit}</p>
        <img>{pose.imageLocation}</img>
    </div>



       <div className="container">
                <div className="row justify-content-center">
                    <div className="col-sm-12 col-lg-6">
                        <div><img src={post.imageLocation} className="post-details-image" /></div>
                        <p className="post-details-title"><b>Post Title: </b> {post.title}</p>
                        <p className="post-details-postedBy"><b>Posted By: </b> {post.userProfile.displayName}</p>
                        <pre className="post-details-content">{post.content}</pre>
                        <p className="post-details-publishDate"><b>Publish Date: </b> {post.publishDateTime.substr(0, 10)}</p>
                        <Button onClick={() => history.push(`/newcomment/${post.id}`)} >Add Comment</Button>
                <Button onClick={toggleEdit}>Edit</Button>
                <Button onClick={toggleDelete}>Delete Post</Button>
                <Link to={`/comments/${id}`} type="button" class="btn btn-info" value="View Comments" size="sm">
            View Comments
          </Link>
                    </div>
                </div>
               
            </div>
</>
    );
};
export default PoseDetails;